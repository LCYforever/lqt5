#!/usr/bin/luajit
--[[*************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https:--www.qt.io/licensing/
**
** self file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use self file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https:--www.qt.io/terms-conditions. For further
** information use the contact form at https:--www.qt.io/contact-us.
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
dofile(arg[0]:gsub('examples/.+', 'examples/init.lua'))

local QtCore = require 'qtcore'
local QtGui = require 'qtgui'
local QtWidgets = require 'qtwidgets'
local QtWebEngineCore = require 'qtwebenginecore'
local QtWebEngineWidgets = require 'qtwebenginewidgets'

local function commandLineUrlArgument()
    local args = QtCore.QCoreApplication.arguments()
    args = args:mid(1)
    for idx = 0, args:size() - 1 do
        local arg = args:at(idx)
        if not arg:startsWith(QtCore.QLatin1Char('-')) then
            return QtCore.QUrl.fromUserInput(arg)
        end
    end
    return QtCore.QUrl(QtCore.QString('http://www.threejs.org'))
end

QtCore.QCoreApplication.setAttribute(QtCore.AA_EnableHighDpiScaling)

local app = QtWidgets.QApplication(1 + select('#', ...), {arg[0], ...})

local view = QtWebEngineWidgets.QWebEngineView()
view:setUrl(commandLineUrlArgument())
view:resize(1024, 750)
view:show()

local devToolsPage = QtWebEngineWidgets.QWebEngineView()
devToolsPage:resize(1024, 750)
devToolsPage:show()

devToolsPage:page():setInspectedPage(view:page())
-- view:page():setDevToolsPage(devToolsPage:page())

return app.exec()