class pruninstallssl {
pruninstallssl::install {'testprun2012.co.il.pfx':

certificatefile => 'testprun2012.co.il.pfx',
certificatepass => 'testprun2012',

} 
}

