import EmberRouter from '@ember/routing/router';
import config from 'netrunnerdb/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('home', { path: '/' });
  this.route('page', function () {
    this.route('advanced-search');
    this.route('banlists');
    this.route('basic-search');
    this.route('card', { path: '/card/:id' });
    this.route('cycle', { path: '/cycle/:id' });
    this.route('cycles');
    this.route('faction', { path: '/faction/:id' });
    this.route('factions');
    this.route('formats');
    this.route('illustrators');
    this.route('reviews');
    this.route('rulings');
    this.route('search');
    this.route('set', { path: '/set/:id' });
    this.route('sets');
    this.route('syntax');
  });
  this.route('private', function () {
    this.route('decks');
    this.route('profile');
  });
});
