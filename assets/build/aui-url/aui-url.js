YUI.add('aui-url', function (A, NAME) {

var QS = A.QueryString,

    _BLANK = '',

    _ANCHOR_SEPARATOR = '#',
    _QUERY_SEPARATOR = '?',
    _SCHEME_SEPARATOR = '://',

    URL_SOURCE = 0,
    URL_PROTOCOL = 1,
    URL_AUTHORITY = 2,
    URL_USER_INFO = 3,
    URL_USER = 4,
    URL_PASSWORD = 5,
    URL_HOST = 6,
    URL_PORT = 7,
    URL_RELATIVE = 8,
    URL_PATH = 9,
    URL_DIRECTORY = 10,
    URL_FILE = 11,
    URL_QUERY = 12,
    URL_ANCHOR = 13;

function Url(url) {
    var instance = this;

    if (!url) {
        throw 'An URL should be specified.';
    }

    instance._indexParts(url);
    instance._indexParameters();
}

// Loose implementation of http://tools.ietf.org/html/rfc3986
// See http://stevenlevithan.com/demo/parseuri/js/assets/parseuri.js
Url.URI_REGEX_RFC3986 = /^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/;

A.mix(Url.prototype, {
    _source: undefined,
    _protocol: undefined,
    _authority: undefined,
    _user_info: undefined,
    _user: undefined,
    _password: undefined,
    _host: undefined,
    _port: undefined,
    _relative: undefined,
    _path: undefined,
    _directory: undefined,
    _file: undefined,
    _query: undefined,
    _anchor: undefined,
    _parameters: undefined,

    addParameter: function(key, values) {
        var instance = this;

        instance.setParameter(key, !instance.hasParameter(key) ?
                                    values :
                                    A.Array(instance.getParameter(key)).concat(values));
    },

    addParameters: function(parameters) {
        var instance = this;

        A.each(parameters, function(val, key) {
            instance.addParameter(key, val);
        });
    },

    hasParameter: function(key) {
        var instance = this;

        return instance._parameters.hasOwnProperty(key);
    },

    getParameter: function(key) {
        var instance = this;

        return instance._parameters[key];
    },

    getParameters: function() {
        var instance = this;

        return instance._parameters;
    },

    getAnchor: function() {
        var instance = this;

        return instance._anchor;
    },

    getAuthority: function() {
        var instance = this;

        return instance._authority;
    },

    getDirectory: function() {
        var instance = this;

        return instance._directory;
    },

    getFile: function() {
        var instance = this;

        return instance._file;
    },

    getHost: function() {
        var instance = this;

        return instance._host;
    },

    getPassword: function() {
        var instance = this;

        return instance._password;
    },

    getPath: function() {
        var instance = this;

        return instance._path;
    },

    getPort: function() {
        var instance = this;

        return instance._port;
    },

    getProtocol: function() {
        var instance = this;

        return instance._protocol;
    },

    getQuery: function() {
        var instance = this;

        return instance._query;
    },

    getRelative: function() {
        var instance = this;

        return instance._relative;
    },

    getSource: function() {
        var instance = this;

        return instance._source;
    },

    getUser: function() {
        var instance = this;

        return instance._user;
    },

    getUserInfo: function() {
        var instance = this;

        return instance._user_info;
    },

    removeParameter: function(key) {
        var instance = this;

        delete instance._parameters[key];

        instance._indexParameters();
    },

    removeParameters: function(parameters) {
        var instance = this;

        A.each(parameters, function(val, key) {
            instance.removeParameter(key);
        });
    },

    setParameter: function(key, opt_values) {
        var instance = this;

        instance._parameters[key] = opt_values;

        instance._indexParameters();
    },

    setParameters: function(parameters) {
        var instance = this;

        A.each(parameters, function(val, key) {
            instance.setParameter(key, val);
        });
    },

    setAnchor: function(val) {
        var instance = this;

        instance._anchor = val;
    },

    setAuthority: function(val) {
        var instance = this;

        instance._authority = val;
    },

    setDirectory: function(val) {
        var instance = this;

        instance._directory = val;
    },

    setFile: function(val) {
        var instance = this;

        instance._file = val;
    },

    setHost: function(val) {
        var instance = this;

        instance._host = val;
    },

    setPassword: function(val) {
        var instance = this;

        instance._password = val;
    },

    setPath: function(val) {
        var instance = this;

        instance._path = val;
    },

    setPort: function(val) {
        var instance = this;

        instance._port = val;
    },

    setProtocol: function(val) {
        var instance = this;

        instance._protocol = val;
    },

    setRelative: function(val) {
        var instance = this;

        instance._relative = val;
    },

    setSource: function(val) {
        var instance = this;

        instance._source = val;
    },

    setUser: function(val) {
        var instance = this;

        instance._user = val;
    },

    setUserInfo: function(val) {
        var instance = this;

        instance._user_info = val;
    },

    toString: function() {
        var instance = this,
            url = [];

        //   foo://example.com:8042/over/there?name=ferret#nose
        //   \_/   \______________/\_________/ \_________/ \__/
        // scheme     authority       path        query   fragment

        if (instance._protocol) {
            url.push(
                instance._protocol,
                _SCHEME_SEPARATOR
            );
        }

        url.push(
            instance._authority,
            instance._path
        );

        if (instance._query) {
            url.push(
                _QUERY_SEPARATOR,
                instance._query
            );
        }

        if (instance._anchor) {
            url.push(
                _ANCHOR_SEPARATOR,
                instance._anchor
            );
        }

        return url.join(_BLANK);
    },

    _indexParameters: function() {
        var instance = this;

        if (!instance._parameters) {
            instance._parameters = QS.parse(instance._query || _BLANK);
        }

        instance._query = QS.stringify(instance._parameters);
    },

    _indexParts: function(url) {
        var instance = this,
            parts = Url.URI_REGEX_RFC3986.exec(url);

        instance._source = parts[URL_SOURCE];
        instance._protocol = parts[URL_PROTOCOL];
        instance._authority = parts[URL_AUTHORITY];
        instance._user_info = parts[URL_USER_INFO];
        instance._user = parts[URL_USER];
        instance._password = parts[URL_PASSWORD];
        instance._host = parts[URL_HOST];
        instance._port = parts[URL_PORT];
        instance._relative = parts[URL_RELATIVE];
        instance._path = parts[URL_PATH];
        instance._directory =  parts[URL_DIRECTORY];
        instance._file =  parts[URL_FILE];
        instance._query =  parts[URL_QUERY];
        instance._anchor =  parts[URL_ANCHOR];
    }
}, true);

A.Url = Url;

}, '2.0.0pr5', {"requires": ["oop", "querystring-parse", "querystring-stringify"]});
