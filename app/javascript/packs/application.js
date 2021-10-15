// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import $ from 'jquery'
import 'select2'
import 'select2/dist/css/select2.css'
import "chartkick/chart.js"
import "channels"
//= require toastr
//= require jquery
//= require jquery_ujs
//= require popper
import 'bootstrap'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function(event){
    $("#flashMessage").delay(3000).slideUp(300);
    $('.js-states').select2();
});