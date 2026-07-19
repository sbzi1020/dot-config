### Kernel 
- [ ] vmm.ko(Virtual Machine Monitor) -> `kldload vmm`
- [ ] The kernel module exposes each VM to userspace as a device node: `/dev/vmm/<vmname>.`

### Userspace
- [ ] `bhyve(8)` is an userspace program. One bhyve process runs one VM
	- [ ] Device emulator(pretends to be all virtual hardware)
	- [ ] vCPU threads(one host thread per vCPU)
	- [ ] talking to the Kernel(`libvmmapi` library to sent cmd to  `vmm.ko` through that `/dev/vmm/<name> `device via `libvmmapi -> ioctls`)