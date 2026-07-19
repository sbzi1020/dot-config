ZFS is a volume manager and file system. 
- The file system all share a pool of available storage.
- You can create snapshots and rollback

## Setup ZFS
```bash
sysrc zfs_enable="YES" # add this to /etc/rc.conf whic loaded first at booting

service zfs start
```
## Commad
```bash
df # to view the pool

[I] fion@freebsd ~> df
Filesystem                    1K-blocks    Used     Avail Capacity  Mounted on
zroot/ROOT/default            471767284 5992680 465774604     1%    /
devfs                                 1       0         1     0%    /dev
/dev/gpt/efiboot0                266144    1360    264784     1%    /boot/efi
zroot/tmp                     465777448    2844 465774604     0%    /tmp


zpool create NAME /dev/da0 
```