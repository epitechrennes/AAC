var connect = require('connect');
var resty = require('resty');
var port_number = 8080;

var app = connect.createServer()
.use(connect.logger('short'))
.use(connect.bodyParser())
.use(connect.cookieParser())
// .use(connect.cookieSession({ secret: 'tobo!', cookie: { maxAge: 60 * 60 * 1000 }}))
// .use(connect.json())
// .use(connect.urlencoded())
// .use(connect.multipart({ uploadDir: "./ "}))
.use(connect.query())
// .use(connect.csrf())
// .use(connect.errorHandler('html')) // launayh : I don't understand how it works !!
.use(resty.middleware(__dirname + '/resources'))
.listen(port_number);


console.log('Server listening on port '+ port_number);