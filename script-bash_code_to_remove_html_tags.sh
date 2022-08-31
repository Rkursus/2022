#!/bin/bash

find -name '*.html' -exec sed "/DOCTYPE/d" -i {} +
