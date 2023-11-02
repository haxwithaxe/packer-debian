source "qemu" "debian" {
	boot_command = [
		"<esc><wait>",
		"install <wait>",
		" preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_path} <wait>",
		"debian-installer=en_US.UTF-8 <wait>",
		"auto <wait>",
		"locale=en_US.UTF-8 <wait>",
		"kbd-chooser/method=us <wait>",
		"keyboard-configuration/xkb-keymap=us <wait>",
		"netcfg/get_hostname={{ .Name }} <wait>",
		"netcfg/get_domain=vagrantup.com <wait>",
		"fb=false <wait>",
		"debconf/frontend=noninteractive <wait>",
		"console-setup/ask_detect=false <wait>",
		"console-keymaps-at/keymap=us <wait>",
		"grub-installer/bootdev=/dev/vda <wait>",
		"<enter><wait>"
	]
	boot_wait = "5s"
	cpus = var.cpus
	disk_size = var.disk_size
	disk_compression = true
	headless = var.headless
	vnc_bind_address = "0.0.0.0"
	http_directory = "http"
	iso_checksum = var.iso_checksum
	iso_url = var.iso_url
	memory = var.memory
	output_directory = var.build_directory
	shutdown_command = "echo '${var.user_password}' | sudo -S /sbin/shutdown -hP now"
	ssh_password = var.user_password
	ssh_port = 22
	ssh_timeout = "10000s"
	ssh_username = var.username
	vm_name = var.vm_name
	qemuargs = [[ "-m", var.memory ], [ "-display", var.qemu_display ]]
}

build {

	sources = ["source.qemu.debian"]
	
	provisioner "shell" {
		environment_vars = [
			"HOME_DIR=/home/${var.username}",
			"http_proxy=${var.http_proxy}",
			"https_proxy=${var.https_proxy}",
			"no_proxy=${var.no_proxy}",
			"ANSIBLE_VAULT_PASSWORD=${var.ansible_vault_password}"
		]
		execute_command = "echo '${var.user_password}' | {{.Vars}} sudo -S -E bash -eux '{{.Path}}'"
		expect_disconnect = true
		scripts = [
			"${path.root}/scripts/update.sh",
			"${path.root}/scripts/cloud-init.sh",
			"${path.root}/scripts/ansible.sh",
			"${path.root}/scripts/networking.sh",
			"${path.root}/scripts/sudoers.sh",
			"${path.root}/scripts/systemd.sh",
			"${path.root}/scripts/cleanup.sh",
			"${path.root}/scripts/minimize.sh"
		]
	}
}

variables {
	build_directory = env("BUILD_DIR")
	cpus = "2"
	disk_size = "65536"
	guest_additions_url = ""
	headless = true
	http_proxy = env("http_proxy")
	https_proxy = env("https_proxy")
	iso_checksum = env("ISO_CHECKSUM")
	iso_url = env("ISO_URL")
	memory = "1024"
	name = "debian-11"
	no_proxy = env("no_proxy")
	preseed_path = "debian-9/preseed.cfg"
	qemu_display = "none"
	version = "TIMESTAMP"
	vm_name = env("IMAGE_NAME")
	username = "hax"
	user_password = "toor"
	ansible_vault_password = env("ANSIBLE_VAULT_PASSWORD")
}

