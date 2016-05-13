#!/bin/bash
TURQ_REGEXP="^(cj|mp|ml|mu|pi|wf|ls|hb|gl|bz)-fe[1-9]?(\.lanl\.gov)?$"
if [[ $1 =~ $TURQ_REGEXP ]]; then
	exec ssh vvv@wtrw2.lanl.gov ssh "$@"
else
	exec ssh "$@"
fi
