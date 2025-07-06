# Workaround for Synology CSI Driver NFS Issue

As of now, I am using the **NFS Subdir External Provisioner** as a workaround
because I have been unable to get NFS working properly with the [Synology CSI driver](https://github.com/zebernst/synology-csi-talos).

This issue is currently being tracked here: [GitHub Issue #21 – NFS not working with Synology CSI Driver](https://github.com/zebernst/synology-csi-talos/issues/21)

Once the problem is resolved upstream or a suitable fix becomes available,
I plan to revisit and migrate back to using the native Synology CSI driver.
