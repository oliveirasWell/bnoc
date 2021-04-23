#!/bin/bash

. scripts/send_notification.sh

set -e

sendFile "../$1"
