#!/bin/bash

export MYWOT_API_KEY=testing
export PIPL_API_KEY=testing
export SHODAN_API_KEY=testing
export VIRUSTOTAL_API_KEY=testing
export RHODEY_IP=5.6.7.8
export RHODEY_PORT=1337
./node_modules/jasmine-node/bin/jasmine-node --coffee ./src/spec