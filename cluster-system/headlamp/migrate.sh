#!/bin/bash
helm upgrade headlamp headlamp/headlamp -n cluster-system -f headlamp-values.yaml --wait --wait-for-jobs -i
