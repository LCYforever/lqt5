#!/usr/bin/luajit
--[[*************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** self file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use self file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use self file under the terms of the BSD license
** as follows:
**
** 'Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, self list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, self list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from self software without specific prior written permission.
**
**
** self SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** 'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES LOSS OF USE,
** DATA, OR PROFITS OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF self SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.'
**
** $QT_END_LICENSE$
**
***************************************************************************]]
dofile(arg[0]:gsub('examples[/\\].+', 'examples/init.lua'))

local QtCore = require 'qtcore'
local QtTest = require 'qttest'

local TestObject = QtCore.QObject()

function TestObject:__static_init()
	self:__addslot('toUpper()', self.toUpper, 'private')
	self:__addslot('toUpper()', self.toUpper_data, 'private')
end

function TestObject:__init()
end

function TestObject:toUpper_data()
	QtTest.addColumnInternal(QtCore.QMetaType.QString, 'string')
	QtTest.addColumnInternal(QtCore.QMetaType.QString, 'result')

	local data = QtTest.newRow('all lower')
	QtTest.IN(data, 'hello')
	QtTest.IN(data, 'HELLO')

	local data = QtTest.newRow('mixed')
	QtTest.IN(data, 'Hello')
	QtTest.IN(data, 'HELLO')

	local data = QtTest.newRow('all upper')
	QtTest.IN(data, 'HELLO')
	QtTest.IN(data, 'HELLO')
end

function TestObject:toUpper()
    -- Type name = *static_cast<Type *>(QTest::qData(#name, ::qMetaTypeId<typename std::remove_cv<Type >::type>()))

    -- QFETCH(QString, string);
    -- QFETCH(QString, result);

    -- QCOMPARE(string.toUpper(), result);

	local str = QtCore.QString('Hello')
	QtTest.QCOMPARE(str:toUpper(), QtCore.QString('HELLO'))
end

TestObject = QtCore.Class(TestObject)

return qTestMain('console', TestObject)
