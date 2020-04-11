#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Timing
==========================

Copyright (C) 2017 Alan Valejo <alanvalejo@gmail.com> All rights reserved

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import time
import csv
import json

from contextlib import contextmanager

__maintainer__ = 'Alan Valejo'
__email__ = 'alanvalejo@gmail.com'
__author__ = 'Alan Valejo'
__credits__ = ['Alan Valejo']
__homepage__ = 'https://www.alanvalejo.com.br'
__license__ = 'GNU.GPL.v3'
__docformat__ = 'markdown en'
__version__ = '0.1'
__date__ = '2019-08-08'

class Timing(object):
	"""
	Timing code snippet.
	Usage:
		timing = Timing(['Time [m]', 'Time [s]'], ['Code snippet'])
		timing.get_now()
		mike = Person()
		mike.think()
		timing.add_elapsed()
		timing.print_tabular()
	"""

	def __init__(self, header=[], rows=[]):
		self.start = 0
		self.header = header
		self.rows = rows
		self.elapsed_set = []

	def get_now(self):
		self.start = time.time()

	def add_elapsed(self):
		elapsed = time.time() - self.start
		self.elapsed_set.append([elapsed // 60, float('%.4f' % (elapsed % 60))])

	def print_tabular(self):
		max_row = max(self.rows + self.header, key=len)
		format_str = '{:>' + str(len(max_row) + 1) + '}'
		row_format = format_str * (len(self.header))
		print(row_format.format(*self.header))
		for row, iten in zip(self.rows, self.elapsed_set):
			print(row_format.format(row, *iten))

	def save_csv(self, output):
		with open(output, 'wb') as csvfile:
			writer = csv.writer(csvfile, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)
			writer.writerow(self.header)
			for row, iten in zip(self.rows, self.elapsed_set):
				writer.writerow([row] + iten)

	def save_json(self, output):
		dictionary = dict(zip(self.rows, self.elapsed_set))
		dictionary['header'] = self.header
		with open(output, 'wb') as jsonfile:
			json.dump(dictionary, jsonfile, indent=4)

	def get_array(self):
		return self.elapsed_set

	def get_array_sec(self):
		result = []
		for item in self.elapsed_set:
			result.append((float(item[0]) * 60) + float(item[1]))
		return result

	@contextmanager
	def timeit_context_add(self, name):
		"""
		For example, you can use it like:

		timing = Timing(['Time [m]', 'Time [s]'], ['Code snippet'])
		with timeit_context('Code snippet'):
			mike = Person()
			mike.think()
		"""

		start = time.time()
		yield
		elapsed = time.time() - start
		self.rows.append(name)
		self.elapsed_set.append([elapsed // 60, '%.4f' % (elapsed % 60)])
