#!/bin/bash
bundle exec puma -C config/puma.rb -e PRODUCTION -d
