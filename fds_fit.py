filename = "lan_master.fds"
f = open(filename, 'rb+')
f.truncate(0xFFEC)
f.close()
