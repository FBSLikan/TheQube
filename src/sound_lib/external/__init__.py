import platform
if platform.system() == 'Windows':
 import pybasswma
if platform.system() != 'Darwin':
 import pybass_aac
 import pybass_alac
 import pybassflac
 import pybassmidi
