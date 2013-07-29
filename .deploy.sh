#!/usr/bin/env bash
s3cmd put * s3://rubyconfargentina.org --recursive --acl-public
