import sys
import botocore

if getattr(sys, 'frozen', False):
    botocore.BOTOCORE_ROOT = sys._MEIPASS
