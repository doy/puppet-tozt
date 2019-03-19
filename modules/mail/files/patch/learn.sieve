require ["vnd.dovecot.execute", "imap4flags", "imapsieve", "environment", "variables"];

if environment :matches "imap.mailbox" "*" {
    set "mailbox" "${1}";
}

if string "${mailbox}" "Junk" {
    setflag "\\seen";
    execute :pipe "spam";
}
else {
    if string "${mailbox}" "Trash" {
        stop;
    }

    execute :pipe "ham";
}
