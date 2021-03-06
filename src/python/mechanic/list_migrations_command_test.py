#!/usr/bin/python
# -*- coding: UTF-8 -*-

import unittest
from list_migrations_command import ListMigrationsCommand
from mock import MagicMock
import tempfile
from command_line import CommandLine
from exceptions import MechanicException

class ListMigrationsCommandTest(unittest.TestCase):
    def setUp(self):
      mechanic = MagicMock()
      self.command = ListMigrationsCommand(mechanic)

    def testRunWithNoMigrations(self):
      args = CommandLine([])
      self.command.run(args)

    def testRunWithInvalidOrderBy(self):
      args = CommandLine(["list-migrations", "--order-by=invalid"])
      with self.assertRaises(MechanicException) as context:
        self.command.run(args)
      self.assertTrue('invalid' in str(context.exception))

