#!/bin/bash
cd C:/Users/ut/Documents/GitHub/2022
find . -type f -name "*.html" -exec sed -i 's/\/2020\//\/2021\//g' {} +
find . -type f -name "*.Rmd" -exec sed -i 's/\/2020\//\/2021\//g' {} +