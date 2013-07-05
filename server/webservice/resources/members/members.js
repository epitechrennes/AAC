var XML = require('xml');

var Members = {
  Resource: {
    //affichage
    get: function(uid, callback) {
      
      var reponse = {
        headers : {"Content-Type" : "text/xml"},
        body : "",
      };

      if(uid >= 10){
        reponse.body = "<status>ok</status>";
      }else{
        reponse.body = "<status>ko</status>";
      }

      callback(null, reponse);
    },
    //création
    post: function(uid, callback) {
      callback(null, {uid: uid, 
        body: this.body, 
        cookies: this.cookies, 
        query: this.query, 
        token : this.token});
    },
    //modification
    put: function(uid, callback) {
      callback(null, {uid: uid, 
        body: this.body, 
        cookies: this.cookies, 
        query: this.query, 
        token : this.token});
    },
    //suppression
    delete: function(uid, callback) {
      callback(null, {uid: uid, 
        body: this.body, 
        cookies: this.cookies, 
        query: this.query, 
        token : this.token});
    }
  },

  Collection: {
    get: function(callback) {
      callback(null, {all: 'members'});
    }
  }
}

module.exports = Members;