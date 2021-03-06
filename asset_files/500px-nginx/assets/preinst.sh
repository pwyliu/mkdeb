#! /bin/sh
# preinst script for nginx

set -e

addnginxuser() {
    # creating nginx group if he isn't already there
    if ! getent group nginx >/dev/null; then
        addgroup --system nginx >/dev/null
    fi

    # creating nginx user if he isn't already there
    if ! getent passwd nginx >/dev/null; then
        adduser \
          --system \
          --disabled-login \
          --ingroup nginx \
          --no-create-home \
          --home /nonexistent \
          --gecos "nginx user" \
          --shell /bin/false \
          nginx  >/dev/null
    fi
}

case "$1" in
    install)
        addnginxuser
        ;;
    upgrade)
        addnginxuser
        ;;

    abort-upgrade)
        ;;

    *)
        echo "preinst called with unknown argument \`$1'" >&2
        exit 0
        ;;
esac

exit 0
