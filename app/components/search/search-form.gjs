import Component from '@glimmer/component';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { tracked } from '@glimmer/tracking';
import Icon from '../icon';
import BsForm from 'ember-bootstrap/components/bs-form';
import PowerSelect from 'ember-power-select/components/power-select';
import PowerSelectMultiple from 'ember-power-select/components/power-select-multiple';

export default class SearchFormComponent extends Component {
  @service router;
  @tracked searchParams;

  constructor() {
    super(...arguments);
    this.searchParams = this.args.searchParams;
    let p = this.searchParams;
    let a = this.args.searchParams;

    p.attribution_operator = this.single(
      this.ifNull(a.attribution_operator, ':'),
      this.textOperators,
    );
    p.flavor_operator = this.single(
      this.ifNull(a.flavor_operator, ':'),
      this.textOperators,
    );
    p.title_operator = this.single(
      this.ifNull(a.title_operator, ':'),
      this.textOperators,
    );
    p.text_operator = this.single(
      this.ifNull(a.text_operator, ':'),
      this.textOperators,
    );
    p.advancement_cost_operator = this.single(
      this.ifNull(a.advancement_cost_operator, ':'),
      this.numericOperators,
    );
    p.agenda_points_operator = this.single(
      this.ifNull(a.agenda_points_operator, ':'),
      this.numericOperators,
    );
    p.base_link_operator = this.single(
      this.ifNull(a.base_link_operator, ':'),
      this.numericOperators,
    );
    p.cost_operator = this.single(
      this.ifNull(a.cost_operator, ':'),
      this.numericOperators,
    );
    p.influence_cost_operator = this.single(
      this.ifNull(a.influence_cost_operator, ':'),
      this.numericOperators,
    );
    p.link_provided_operator = this.single(
      this.ifNull(a.link_provided_operator, ':'),
      this.numericOperators,
    );
    p.memory_usage_operator = this.single(
      this.ifNull(a.memory_usage_operator, ':'),
      this.numericOperators,
    );
    p.mu_provided_operator = this.single(
      this.ifNull(a.mu_provided_operator, ':'),
      this.numericOperators,
    );
    p.num_printed_subroutines_operator = this.single(
      this.ifNull(a.num_printed_subroutines_operator, ':'),
      this.numericOperators,
    );
    p.num_printings_operator = this.single(
      this.ifNull(a.num_printings_operator, ':'),
      this.numericOperators,
    );
    p.position_operator = this.single(
      this.ifNull(a.position_operator, ':'),
      this.numericOperators,
    );
    p.quantity_operator = this.single(
      this.ifNull(a.quantity_operator, ':'),
      this.numericOperators,
    );
    p.recurring_credits_provided_operator = this.single(
      this.ifNull(a.recurring_credits_provided_operator, ':'),
      this.numericOperators,
    );
    p.strength_operator = this.single(
      this.ifNull(a.strength_operator, ':'),
      this.numericOperators,
    );
    p.trash_cost_operator = this.single(
      this.ifNull(a.trash_cost_operator, ':'),
      this.numericOperators,
    );

    p.additional_cost = this.single(a.additional_cost, this.yesNo);
    p.advanceable = this.single(a.advanceable, this.yesNo);
    p.card_cycle = this.multi(a.card_cycle, this.args.cardCycles);
    p.card_pool = this.multi(a.card_pool, this.args.cardPools);
    p.card_set = this.multi(a.card_set, this.args.cardSets);
    p.card_subtype_id = this.multi(a.card_subtype_id, this.args.cardSubtypes);
    p.card_type_id = this.multi(a.card_type_id, this.args.cardTypes);
    p.designed_by = this.single(a.designed_by, this.orgs);
    p.display = this.single(
      this.ifNull(a.display, 'checklist'),
      this.displayOptions,
    );
    p.faction_id = this.multi(a.faction_id, this.args.factions);
    p.format = this.multi(a.format, this.args.formats);
    p.gains_subroutines = this.single(a.gains_subroutines, this.yesNo);
    p.illustrator_id = this.multi(a.illustrator_id, this.args.illustrators);
    p.interrupt = this.single(a.interrupt, this.yesNo);
    p.is_unique = this.single(a.is_unique, this.yesNo);
    p.latest_printing_only = this.single(a.latest_printing_only, this.yesNo);
    p.max_records = this.single(
      this.ifNull(a.max_records, 100),
      this.maxRecords,
    );
    p.on_encounter_effect = this.single(a.on_encounter_effect, this.yesNo);
    p.performs_trace = this.single(a.performs_trace, this.yesNo);
    p.released_by = this.single(a.released_by, this.orgs);
    p.restriction_id = this.multi(a.restriction_id, this.args.restrictions);
    p.rez_effect = this.single(a.rez_effect, this.yesNo);
    p.side_id = this.single(a.side_id, this.args.sides);
    p.snapshot = this.multi(a.snapshot, this.args.snapshots);
    p.trash_ability = this.single(a.trash_ability, this.yesNo);
  }

  ifNull(param, def) {
    let r = null;
    if (param) {
      r = param;
    } else if (def) {
      r = def;
    }
    return r;
  }

  // Provide value for single select element.
  single(param, objects) {
    if (!param) {
      return null;
    }
    let id = String(param).toLowerCase();
    let matches = objects.filter((x) => x.id == id);
    if (matches.length > 0) {
      return matches[0];
    }
    return null;
  }

  // Provide values for multi-select element.
  multi(param, objects) {
    if (!param) {
      return [];
    }
    let ids = param.toLowerCase().split?.(',');
    return objects.filter((x) => ids.includes(x.id));
  }

  textOperators = [
    { id: ':', name: 'LIKE' },
    { id: '!', name: 'NOT LIKE' },
    { id: '=~', name: 'REGEX LIKE' },
    { id: '!=~', name: 'REGEX NOT LIKE' },
  ];
  numericOperators = [
    { id: ':', name: '=' },
    { id: '!', name: '!=' },
    { id: '<', name: '<' },
    { id: '<=', name: '<=' },
    { id: '>', name: '>' },
    { id: '>=', name: '>=' },
  ];
  displayOptions = [
    { id: 'checklist', name: 'Checklist' },
    { id: 'full', name: 'Full Card' },
    { id: 'images', name: 'Image Only' },
    { id: 'text', name: 'Text Only' },
  ];
  yesNo = [
    { id: 't', name: 'Yes' },
    { id: 'f', name: 'No' },
  ];
  oneToSix = [
    { id: '', name: 'Any' },
    { id: 1, name: 1 },
    { id: 2, name: 2 },
    { id: 3, name: 3 },
    { id: 4, name: 4 },
    { id: 5, name: 5 },
    { id: 6, name: 6 },
  ];
  orgs = [
    { id: 'null_signal_games', name: 'Null Signal Games' },
    { id: 'fantasy_flight_games', name: 'Fantasy Flight Games' },
  ];
  maxRecords = [25, 50, 100, 250, 500, 1000, 5000].map((x) => {
    return { id: x, name: x };
  });

  getText(p, q, field) {
    if (p[field] && p[field].trim().length > 0) {
      q[field] = p[field].trim();
    } else {
      q[field] = null;
    }
  }
  getSelect(p, q, field) {
    if (p[field]) {
      q[field] = p[field].id;
    } else {
      q[field] = null;
    }
  }

  getMultiSelect(p, q, field) {
    if (p[field] && p[field].length != 0) {
      q[field] = p[field].map((x) => x.id);
    } else {
      q[field] = null;
    }
  }

  // TODO(plural): sort params to aid caching.
  @action doSearch() {
    let p = this.searchParams;
    let q = {};

    this.getMultiSelect(p, q, 'card_cycle');
    this.getMultiSelect(p, q, 'card_pool');
    this.getMultiSelect(p, q, 'card_set');
    this.getMultiSelect(p, q, 'card_subtype_id');
    this.getMultiSelect(p, q, 'card_type_id');
    this.getMultiSelect(p, q, 'faction_id');
    this.getMultiSelect(p, q, 'format');
    this.getMultiSelect(p, q, 'illustrator_id');
    this.getMultiSelect(p, q, 'restriction_id');
    this.getMultiSelect(p, q, 'snapshot');
    this.getSelect(p, q, 'additional_cost');
    this.getSelect(p, q, 'advanceable');
    this.getSelect(p, q, 'advancement_cost_operator');
    this.getSelect(p, q, 'agenda_points_operator');
    this.getSelect(p, q, 'attribution_operator');
    this.getSelect(p, q, 'base_link_operator');
    this.getSelect(p, q, 'cost_operator');
    this.getSelect(p, q, 'designed_by');
    this.getSelect(p, q, 'display');
    this.getSelect(p, q, 'flavor_operator');
    this.getSelect(p, q, 'gains_subroutines');
    this.getSelect(p, q, 'influence_cost_operator');
    this.getSelect(p, q, 'interrupt');
    this.getSelect(p, q, 'is_unique');
    this.getSelect(p, q, 'latest_printing_only');
    this.getSelect(p, q, 'link_provided_operator');
    this.getSelect(p, q, 'max_records');
    this.getSelect(p, q, 'memory_usage_operator');
    this.getSelect(p, q, 'mu_provided_operator');
    this.getSelect(p, q, 'num_printed_subroutines_operator');
    this.getSelect(p, q, 'num_printings_operator');
    this.getSelect(p, q, 'on_encounter_effect');
    this.getSelect(p, q, 'performs_trace');
    this.getSelect(p, q, 'position_operator');
    this.getSelect(p, q, 'quantity_operator');
    this.getSelect(p, q, 'recurring_credits_provided_operator');
    this.getSelect(p, q, 'released_by');
    this.getSelect(p, q, 'rez_effect');
    this.getSelect(p, q, 'side_id');
    this.getSelect(p, q, 'strength_operator');
    this.getSelect(p, q, 'text_operator');
    this.getSelect(p, q, 'title_operator');
    this.getSelect(p, q, 'trash_ability');
    this.getSelect(p, q, 'trash_cost_operator');
    this.getText(p, q, 'advancement_cost');
    this.getText(p, q, 'agenda_points');
    this.getText(p, q, 'attribution');
    this.getText(p, q, 'base_link');
    this.getText(p, q, 'cost');
    this.getText(p, q, 'flavor');
    this.getText(p, q, 'influence_cost');
    this.getText(p, q, 'link_provided');
    this.getText(p, q, 'memory_usage');
    this.getText(p, q, 'mu_provided');
    this.getText(p, q, 'num_printed_subroutines');
    this.getText(p, q, 'num_printings');
    this.getText(p, q, 'position');
    this.getText(p, q, 'quantity');
    this.getText(p, q, 'recurring_credits_provided');
    this.getText(p, q, 'strength');
    this.getText(p, q, 'text');
    this.getText(p, q, 'title');
    this.getText(p, q, 'trash_cost');

    this.router.transitionTo(this.router.currentRouteName, {
      queryParams: q,
    });
  }

  <template>
    <h1>Advanced Search Form</h1>

    {{#if @searchParams.query}}
      <p>Free form query is: <strong>{{@searchParams.query}}</strong></p>
    {{/if}}

    <BsForm
      @formLayout='vertical'
      @onSubmit={{this.doSearch}}
      @model={{this.searchParams}}
      as |form|
    >
      <fieldset>
        <legend>Title &amp; Text</legend>
        <div class='row'>
          <div class='col-sm-2'>
            <form.element @label='&nbsp;' @property='title_operator' as |el|>
              <PowerSelect
                @options={{this.textOperators}}
                @selected={{this.searchParams.title_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.title_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element
              @controlType='text'
              @label='Title'
              @property='title'
            />
          </div>
          <div class='col-sm-2'>
            <form.element @label='&nbsp;' @property='text_operator' as |el|>
              <PowerSelect
                @options={{this.textOperators}}
                @selected={{this.searchParams.text_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.text_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element @controlType='text' @label='Text' @property='text' />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Printing Attributes</legend>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @label='Latest Printing Only?'
              @property='latest_printing_only'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.latest_printing_only}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.latest_printing_only)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-1'>
            <form.element @label='&nbsp;' @property='position_operator' as |el|>
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.position_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.position_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Position In Set'
              @property='position'
            />
          </div>
          <div class='col-sm-1'>
            <form.element @label='&nbsp;' @property='quantity_operator' as |el|>
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.quantity_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.quantity_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Quantity In Set'
              @property='quantity'
            />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='num_printings_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.num_printings_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.num_printings_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Num Printings'
              @property='num_printings'
            />
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-2'>
            <form.element @label='&nbsp;' @property='flavor_operator' as |el|>
              <PowerSelect
                @options={{this.textOperators}}
                @selected={{this.searchParams.flavor_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.flavor_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element
              @controlType='text'
              @label='Flavor Text'
              @property='flavor'
            />
          </div>
          <div class='col-sm-6'>
            <form.element
              @label='Illustrators'
              @property='illustrator_id'
              as |el|
            >
              <PowerSelectMultiple
                @options={{@illustrators}}
                @selected={{this.searchParams.illustrator_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.illustrator_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Card Attributes</legend>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element @label='Side' @property='side_id' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{@sides}}
                @selected={{this.searchParams.side_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.side_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Faction' @property='faction_id' as |el|>
              <PowerSelectMultiple
                @options={{@factions}}
                @selected={{this.searchParams.faction_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.faction_id)}}
                as |x|
              >
                <Icon @icon={{x.id}} />
                {{!template-lint-disable no-whitespace-for-layout}}
                {{x.name}}'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Card Type' @property='card_type_id' as |el|>
              <PowerSelectMultiple
                @options={{@cardTypes}}
                @selected={{this.searchParams.card_type_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.card_type_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Card Subtype'
              @property='card_subtype_id'
              as |el|
            >
              <PowerSelectMultiple
                @options={{@cardSubtypes}}
                @selected={{this.searchParams.card_subtype_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.card_subtype_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element @label='Unique?' @property='is_unique' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.is_unique}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.is_unique)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='influence_cost_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.influence_cost_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.influence_cost_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Influence'
              @property='influence_cost'
            />
          </div>
          <div class='col-sm-1'>
            <form.element @label='&nbsp;' @property='cost_operator' as |el|>
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.cost_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.cost_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element @controlType='text' @label='Cost' @property='cost' />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='advancement_cost_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.advancement_cost_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn
                  (mut this.searchParams.advancement_cost_operator)
                }}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Advancement Cost'
              @property='advancement_cost'
            />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='agenda_points_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.agenda_points_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.agenda_points_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Agenda Points'
              @property='agenda_points'
            />
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='base_link_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.base_link_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.base_link_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Base Link'
              @property='base_link'
            />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='memory_usage_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.memory_usage_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.memory_usage_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Memory Usage'
              @property='memory_usage'
            />
          </div>
          <div class='col-sm-1'>
            <form.element @label='&nbsp;' @property='strength_operator' as |el|>
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.strength_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.strength_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Strength'
              @property='strength'
            />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='trash_cost_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.trash_cost_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.trash_cost_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Trash Cost'
              @property='trash_cost'
            />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Card Abilities</legend>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @label='Has Additional Cost?'
              @property='additional_cost'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.additional_cost}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.additional_cost)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Advanceable?' @property='advanceable' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.advanceable}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.advanceable)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Gains Subroutines?'
              @property='gains_subroutines'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.gains_subroutines}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.gains_subroutines)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Has Interrupt?' @property='interrupt' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.interrupt}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.interrupt)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element
              @label='On Encounter Effect?'
              @property='on_encounter_effect'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.on_encounter_effect}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.on_encounter_effect)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Performs Trace?'
              @property='performs_trace'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.performs_trace}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.performs_trace)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Rez Effect?' @property='rez_effect' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.rez_effect}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                @triggerRole='listbox'
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.rez_effect)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element
              @label='Trash Ability?'
              @property='trash_ability'
              as |el|
            >
              <PowerSelect
                @allowClear={{true}}
                @options={{this.yesNo}}
                @selected={{this.searchParams.trash_ability}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.trash_ability)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='link_provided_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.link_provided_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.link_provided_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Link Provided'
              @property='link_provided'
            />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='mu_provided_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.mu_provided_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.mu_provided_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='MU Provided'
              @property='mu_provided'
            />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='num_printed_subroutines_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.num_printed_subroutines_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn
                  (mut this.searchParams.num_printed_subroutines_operator)
                }}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Num Printed Subroutines'
              @property='num_printed_subroutines'
            />
          </div>
          <div class='col-sm-1'>
            <form.element
              @label='&nbsp;'
              @property='recurring_credits_provided_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.numericOperators}}
                @selected={{this.searchParams.recurring_credits_provided_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn
                  (mut this.searchParams.recurring_credits_provided_operator)
                }}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @controlType='text'
              @label='Recurring Credits Provided'
              @property='recurring_credits_provided'
            />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Cycles & Sets</legend>
        <div class='row'>
          <div class='col-sm-6'>
            <form.element @label='Cycle' @property='card_cycle' as |el|>
              <PowerSelectMultiple
                @options={{@cardCycles}}
                @selected={{this.searchParams.card_cycle}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.card_cycle)}}
                as |x|
              >
                <Icon @icon={{x.id}} />
                {{!template-lint-disable no-whitespace-for-layout}}
                {{x.name}}'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-6'>
            <form.element @label='Set' @property='card_set' as |el|>
              <PowerSelectMultiple
                @options={{@cardSets}}
                @selected={{this.searchParams.card_set}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.card_set)}}
                as |x|
              >
                <Icon @icon={{x.cardCycleId}} />
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Formats, Card Pools, Restrictions, & Snapshots</legend>
        <div class='row'>
          <div class='col-sm-12'>
            <form.element @label='Snapshot' @property='snapshot' as |el|>
              <PowerSelectMultiple
                @options={{@snapshots}}
                @selected={{this.searchParams.snapshot}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.snapshot)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
        <div class='row'>
          <div class='col-sm-4'>
            <form.element @label='Format' @property='format' as |el|>
              <PowerSelectMultiple
                @options={{@formats}}
                @selected={{this.searchParams.format}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.format)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element @label='Card Pool' @property='card_pool' as |el|>
              <PowerSelectMultiple
                @options={{@cardPools}}
                @selected={{this.searchParams.card_pool}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.card_pool)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element
              @label='Restriction List'
              @property='restriction_id'
              as |el|
            >
              <PowerSelectMultiple
                @options={{@restrictions}}
                @selected={{this.searchParams.restriction_id}}
                @searchEnabled={{true}}
                @searchField='name'
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.restriction_id)}}
                as |x|
              >
                {{x.name}}
              </PowerSelectMultiple>
            </form.element>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Designers and Publishers</legend>
        <div class='row'>
          <div class='col-sm-3'>
            <form.element @label='Designed By' @property='designed_by' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.orgs}}
                @selected={{this.searchParams.designed_by}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.designed_by)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-3'>
            <form.element @label='Released By' @property='released_by' as |el|>
              <PowerSelect
                @allowClear={{true}}
                @options={{this.orgs}}
                @selected={{this.searchParams.released_by}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.released_by)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-2'>
            <form.element
              @label='&nbsp;'
              @property='attribution_operator'
              as |el|
            >
              <PowerSelect
                @options={{this.textOperators}}
                @selected={{this.searchParams.attribution_operator}}
                @triggerId={{el.id}}
                {{!-- @onFocus={{action.focus}} --}}
                @onChange={{fn (mut this.searchParams.attribution_operator)}}
                as |x|
              >
                {{x.name}}
              </PowerSelect>
            </form.element>
          </div>
          <div class='col-sm-4'>
            <form.element
              @controlType='text'
              @label='Champion Card Designer'
              @property='attribution'
            />
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>Cycles & Sets</legend>
        <div class='row'>
          <div class='col-sm-6'>
          </div>
          <div class='col-sm-6'>
          </div>
        </div>
      </fieldset>

      <div class='row'>
        <div class='col-sm-3'>
          <form.element @label='Num Records' @property='max_records' as |el|>
            <PowerSelect
              @options={{this.maxRecords}}
              @selected={{this.searchParams.max_records}}
              @triggerId={{el.id}}
              {{!-- @onFocus={{action.focus}} --}}
              @onChange={{fn (mut this.searchParams.max_records)}}
              as |x|
            >
              {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
        <div class='col-sm-3'>
          <form.element @label='Display' @property='display' as |el|>
            <PowerSelect
              @options={{this.displayOptions}}
              @selected={{this.searchParams.display}}
              @triggerId={{el.id}}
              {{!-- @onFocus={{action.focus}} --}}
              @onChange={{fn (mut this.searchParams.display)}}
              as |x|
            >
              View as
              {{x.name}}
            </PowerSelect>
          </form.element>
        </div>
        <div class='col-sm-2'>
          <form.submitButton>Submit</form.submitButton>
        </div>
      </div>
    </BsForm>
  </template>
}
