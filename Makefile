apply = puppet apply --noop --modulepath=..
up = vagrant up
provider = --provider vmware_fusion

test: tests/*.pp
	find tests -name \*.pp | xargs -n 1 -t $(apply)

vm_server:
	$(up) server $(provider)

vm_client:
	$(up) client $(provider)

vm_autodetect:
	$(up) autodetect $(provider)

vm_autoupdate:
	$(up) autoupdate $(provider)
