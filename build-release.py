#!/usr/bin/env python
"""
    build-release.py -- Takes developer directories and creates 
                         student-useable directory and zip file.
    jmh/04.13.2011
"""

import os, shutil
from subprocess import call
from glob import glob

# command line options
from optparse import OptionParser
parser = OptionParser()
parser.add_option("-v", "--version", dest="version", default='0.1',
                  help="build student VERSION", metavar="VERSION")
parser.add_option("-n", "--no-clobber", 
                  action="store_true", dest="no_clobber", default=False,
                  help="do not overwrite an existing directory or zip file")

(options, args) = parser.parse_args()

version    = options.version
no_clobber = options.no_clobber

# names
base_name = 'ncsuthesis'
full_name = base_name + '-' + version
zip_file  = full_name + '.zip'

# for no_clobber, checking if files exist
if no_clobber:
    if os.path.isfile(zip_file):
        raise Exception(zip_file + ' already exists')
    elif os.path.exists(full_name):
        raise Exception(full_name + '/ directory already exists')
# otherwise, remove them
else:
    try:
        shutil.rmtree(full_name)
        os.remove(zip_file)
    except Exception:
        pass


# copy template files to new base directory
shutil.copytree('template', full_name)



# make dtx file
os.chdir('dtx')
call(['make'])

# copy ncsuthesis.cls to new directory
shutil.copy(base_name + '.cls', '../'+full_name)

call(['make', 'clean'])
os.chdir('..')


# copy other style files to new directory
for f in glob('other-sty/*'):
    shutil.copy(f, full_name)


# make zip archive
call(['zip', '-r', zip_file, full_name])

