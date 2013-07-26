#!/usr/bin/env bash
s3cmd put * s3://rubyconfar --recursive --acl-public
