var Members = {
  Resource: {
    //affichage
    get: function(uid, callback) {
      // console.log("affichage membre" + uid);
      callback(null, {uid: uid, 
        body: this.body, 
        cookies: this.cookies, 
        query: this.query, 
        token : this.token});
    },
    //création
    post: function(uid, callback) {
      // console.log("création membre" + uid);
      callback(null, {uid: uid, 
        body: this.body, 
        cookies: this.cookies, 
        query: this.query, 
        token : this.token});
    },
    //modification
    put: function(uid, callback) {
      // console.log("modification membre" + uid);
      callback(null, {uid: uid, 
        body: this.body, 
        cookies: this.cookies, 
        query: this.query, 
        token : this.token});
    },
    //suppression
    delete: function(uid, callback) {
      // console.log("suppression membre" + uid);
      callback(null, {uid: uid, 
        body: this.body, 
        cookies: this.cookies, 
        query: this.query, 
        token : this.token});
    }
  },

  Collection: {
    get: function(callback) {
      // console.log("membres")
      callback(null, {all: 'members'});
    }
  }
}

module.exports = Members;