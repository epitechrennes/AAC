// var XML = require('xml');
var mysql = require('mysql');
var conf = require('../../db_conf.json');


var reponse = {
  headers : {"Content-Type" : "text/xml"},
  body : ""
};

var Members = {
  Resource: {
    //affichage
    get: function(uid, callback) {

      var request = 'SELECT COUNT(* AS nb FROM aacdb.active_rules \
        WHERE serial="' + uid + '" \
        AND dtstart<=NOW() AND dtend>=NOW();'

      var connection = mysql.createConnection(conf);
      connection.connect();
      connection.query(request, function(err, rows, fields){
        if (err){
          callback(err, {headers : {"Content-Type" : "text/plain"}, body : "Erreur"});
        }else{
          if(rows[0].nb > 0){
            reponse.body = "<status>ok</status>";
          }else{
            reponse.body = "<status>ko</status>";
          }
          callback(error, reponse);
        }
      });
      
      connection.end();
    }
  }
}

module.exports = Members;