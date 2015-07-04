class pruninstalliis::create_net_share {
net_share {'Chumanclick':
  ensure        => present,
  path          => 'c:\humanclick',
  remark        => 'Puppet-created-share-Disk-C',
  maximumusers  => unlimited,
  cache         => none,
  permissions   => ['EVERYONE,READ'], 
}
net_share {'Dhumanclick':
  ensure        => present,
  path          => 'd:\humanclick',
  remark        => 'Puppet-created-share-Disk-D',
  maximumusers  => unlimited,
  cache         => none,
  permissions   => ['EVERYONE,READ'],
}
}
