# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# distutils: language = c++

from libc.string cimport const_char
from libcpp.list cimport list as std_list
from pyarrow.includes.common cimport *
from pyarrow.includes.libarrow cimport (CArray, CSchema, CStatus,
                                        CTable, CMemoryPool,
                                        CKeyValueMetadata,
                                        CRecordBatch,
                                        RandomAccessFile, OutputStream,
                                        TimeUnit)


cdef extern from "arrow/adapters/orc/adapter.h" namespace "arrow::adapters::orc" nogil:
    cdef cppclass ORCFileReader:

        @staticmethod
        CStatus Open(const shared_ptr[RandomAccessFile]& file,
                     CMemoryPool* pool,
                     unique_ptr[ORCFileReader]* reader)

        CStatus ReadSchema(shared_ptr[CSchema]* out)

        CStatus ReadStripe(uint64_t stripe, shared_ptr[CRecordBatch]* out)
        CStatus ReadStripe(uint64_t stripe, std_list[uint64_t], shared_ptr[CRecordBatch]* out)

        CStatus Read(shared_ptr[CRecordBatch]* out)
        CStatus Read(std_list[uint64_t], shared_ptr[CRecordBatch]* out)

        uint64_t NumberOfStripes()

        uint64_t NumberOfRows()