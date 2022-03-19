#!/bin/sh

conf_location="/usr/local/share/puppet-tozt"
conf_repo="https://github.com/doy/puppet-tozt"

create_droplet() {
    _name="$1"
    _size="$2"

    if [ -n "${3:-}" ]; then
        _volume_opt="--volumes $3"
    else
        _volume_opt=""
    fi

    echo "Creating droplet for ${_name}..."

    # shellcheck disable=SC2086
    _data=$(doctl \
        -t "$(cat /mnt/digitalocean)" \
        compute droplet create \
        "$_name" \
        --image debian-9-x64 \
        --region nyc3 \
        --size ${_size} \
        --ssh-keys 30728567 \
        $_volume_opt \
        --format ID,PublicIPv4 \
        --no-header \
        --wait)
    id=$(echo "$_data" | awk '{print $1}')
    ip=$(echo "$_data" | awk '{print $2}')

    echo "Created droplet with id $id and ip $ip"
}

remote() {
    # shellcheck disable=SC2029
    ssh -oStrictHostKeyChecking=accept-new root@"$ip" "$@"
}

ensure_conf_exists() {
    if remote test -d "$conf_location"; then
        remote "cd '$conf_location' && git pull"
    else
        remote "mkdir -p '$conf_location'"
        remote "cd '$conf_location' && git clone '$conf_repo' ."
    fi
    remote "cd '$conf_location' && git submodule update --init --recursive"
}

provision_droplet() {
    _name="$1"

    echo "Provisioning droplet ${_name}..."

    while ! remote true; do
        sleep 5
    done

    if remote test ! -e /usr/bin/pacman; then
        remote apt-get -y update
        remote apt-get -y install git
        ensure_conf_exists
        remote "cd '$conf_location/digitalocean-debian-to-arch' && bash install.sh --i_understand_that_this_droplet_will_be_completely_wiped --extra_packages 'puppet git ruby-shadow'"
        sleep 30
        while ! remote true; do
            sleep 30
        done
    fi

    ensure_conf_exists
    if [ -d "/mnt/puppet/${_name}" ]; then
        scp -r "/mnt/puppet/${_name}/" root@"$ip":/usr/local/share/puppet-tozt/modules/secret/files
        remote "cd '$conf_location' && puppet apply --modulepath=./modules manifests"
    fi

    echo "Done provisioning"
}
