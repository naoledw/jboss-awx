#!/bin/bash
# Usage: artemis_manage.sh start|stop|restart|status

ACTION=$1
ARTEMIS_HOME="/u01/artemis/mastermq"
SERVICE_SCRIPT="$ARTEMIS_HOME/bin/artemis-service"

case "$ACTION" in
    start)
        echo "Starting Artemis..."
        sudo $SERVICE_SCRIPT start
        ;;
    stop)
        echo "Stopping Artemis..."
        sudo $SERVICE_SCRIPT stop
        ;;
    restart)
        echo "Restarting Artemis..."
        sudo $SERVICE_SCRIPT stop
        sleep 2
        sudo $SERVICE_SCRIPT start
        ;;
    status)
        if pgrep -f artemis >/dev/null; then
            echo "Artemis is running"
        else
            echo "Artemis is stopped"
        fi
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac

