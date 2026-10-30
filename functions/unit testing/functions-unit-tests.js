/* eslint-disable*/
// after firebase-functions-test has been initialized
// relative path to functions code
// import myFunctions from '../index.js';
// const test = require("firebase-functions-test\n")({
require("firebase-functions-test")({
  // I'm not sure about the below line.
  databaseURL: "https://wow-we-won.firebaseio.com",
  storageBucket: "wow-we-won.firebasestorage.app",
  projectId: "wow-we-won",
  // The path need to use '\\' instead of '/'.
}, "D:\\L Ganyile\\Sky And Stars 4All Pty LTD\\Wow\\wow\\wow-we-won-credentials.json",
);
