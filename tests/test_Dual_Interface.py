#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
from wifite import Configuration
from wifite.__main__ import Wifite

class TestDualInterface(unittest.TestCase):
    ''' Test suite for dual interface functionality in Wifite '''

    def setUp(self):
        ''' Set up the test environment '''
        Configuration.interface_attack = 'wlan0mon'
        Configuration.interface_scan = 'wlan1mon'

    def test_dual_interface_initialization(self):
        ''' Test that both interfaces are set correctly '''
        wifite = Wifite()
        wifite.start()

        # Assert that the interfaces are initialized correctly
        self.assertEqual(Configuration.interface_attack, 'wlan0mon', 
                         "Attack interface should be set to 'wlan0mon'")
        self.assertEqual(Configuration.interface_scan, 'wlan1mon', 
                         "Scan interface should be set to 'wlan1mon'")

if __name__ == '__main__':
    unittest.main()#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
from wifite import Configuration
from wifite.__main__ import Wifite

class TestDualInterface(unittest.TestCase):
    ''' Test suite for dual interface functionality in Wifite '''

    def setUp(self):
        ''' Set up the test environment '''
        Configuration.interface_attack = 'wlan0mon'
        Configuration.interface_scan = 'wlan1mon'

    def test_dual_interface_initialization(self):
        ''' Test that both interfaces are set correctly '''
        wifite = Wifite()
        wifite.start()

        # Assert that the interfaces are initialized correctly
        self.assertEqual(Configuration.interface_attack, 'wlan0mon', 
                         "Attack interface should be set to 'wlan0mon'")
        self.assertEqual(Configuration.interface_scan, 'wlan1mon', 
                         "Scan interface should be set to 'wlan1mon'")

if __name__ == '__main__':
    unittest.main()