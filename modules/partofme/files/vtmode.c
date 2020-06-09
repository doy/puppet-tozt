#include <stdio.h>
#include <string.h>

#include <fcntl.h>
#include <linux/kd.h>
#include <sys/ioctl.h>

int main(int argc, char *argv[]) {
    int err, fd, mode;

    if (argc != 2) {
        fprintf(stderr, "usage: %s <graphics|text>\n", argv[0]);
        return 1;
    }

    if (strcmp(argv[1], "graphics") == 0) {
        mode = KD_GRAPHICS;
    }
    else if (strcmp(argv[1], "text") == 0) {
        mode = KD_TEXT;
    }
    else {
        fprintf(stderr, "usage: %s <graphics|text>\n", argv[0]);
        return 1;
    }

    fd = open("/dev/tty0", O_WRONLY);
    if (fd < 0) {
        perror(argv[0]);
        return 1;
    }

    err = ioctl(fd, KDSETMODE, mode);
    if (err < 0) {
        perror(argv[0]);
        return 1;
    }

    return 0;
}
