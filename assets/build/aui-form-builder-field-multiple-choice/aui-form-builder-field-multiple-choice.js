YUI.add('aui-form-builder-field-multiple-choice', function (A, NAME) {

var Lang = A.Lang,

	isArray = Lang.isArray,

	AArray = A.Array,

	ACCEPT_CHILDREN = 'acceptChildren',
	EDITOR = 'editor',
	FIELD = 'field',
	FORM_BUILDER = 'form-builder',
	FORM_BUILDER_MULTIPLE_CHOICE_FIELD = 'form-builder-multiple-choice-field',
	FORM_BUILDER_OPTIONS_EDITOR = 'form-builder-options-editor',
	HIDDEN = 'hidden',
	LABEL = 'label',
	NAME = 'name',
	OPTION_TEMPLATE = 'optionTemplate',
	OPTIONS = 'options',
	PREDEFINED_VALUE = 'predefinedValue',
	RENDER = 'render',
	SELECTED = 'selected',
	SHOW_LABEL = 'showLabel',
	TEMPLATE_NODE = 'templateNode',

	_COMMA = ',',
	_EMPTY_STR = '',
	_SPACE = ' ',

	getCN = A.getClassName,

	getEditorOptions = function(val) {
		var options = {};

		AArray.each(
			val,
			function(item, index, collection) {
				options[item.value] = item.label;
			}
		);

		return options;
	},

	CSS_FORM_BUILDER_FIELD = getCN(FORM_BUILDER, FIELD),
	CSS_FORM_BUILDER_OPTIONS_EDITOR_HIDDEN = getCN(FORM_BUILDER, OPTIONS, EDITOR, HIDDEN);

var OptionsEditor = A.Component.create({
	NAME: FORM_BUILDER_OPTIONS_EDITOR,

	ATTRS: {
		editable: {
			setter: function() {
				return false;
			}
		}
	},

	EXTENDS: A.RadioCellEditor,

	prototype: {
		ELEMENT_TEMPLATE: '<div class="' + CSS_FORM_BUILDER_OPTIONS_EDITOR_HIDDEN + '"></div>',

		initializer: function() {
			var instance = this;

			instance.after(RENDER, function() {
				instance._onEditEvent();
			});
		},

		_onSubmit: function(event) {
			var instance = this;

			instance.saveOptions();

			OptionsEditor.superclass._onSubmit.apply(this, arguments);
		}
	}
});

var FormBuilderMultipleChoiceField = A.Component.create({
	NAME: FORM_BUILDER_MULTIPLE_CHOICE_FIELD,

	ATTRS: {
		acceptChildren: {
			value: false,
			readOnly: true
		},

		options: {
			value: [
				{
					label: 'option 1',
					value: 'value 1'
				},
				{
					label: 'option 2',
					value: 'value 2'
				},
				{
					label: 'option 3',
					value: 'value 3'
				}
			]
		},

		optionTemplate: {
			value: '<option value="{value}">{label}</option>'
		},

		predefinedValue: {
			setter: function(val) {
				return isArray(val) ? val : [val];
			}
		}
	},

	UI_ATTRS: [ACCEPT_CHILDREN, LABEL, NAME, OPTIONS, PREDEFINED_VALUE, SHOW_LABEL],

	CSS_PREFIX: CSS_FORM_BUILDER_FIELD,

	EXTENDS: A.FormBuilderField,

	prototype: {

		initializer: function() {
			var instance = this,
				options = instance.get(OPTIONS);

			instance.predefinedValueEditor = new A.DropDownCellEditor({
				options: getEditorOptions(options)
			});
		},

		getPropertyModel: function() {
			var instance = this,
				options = instance.get(OPTIONS),
				strings = instance.getStrings();

			var model = A.FormBuilderMultipleChoiceField.superclass.getPropertyModel.apply(instance, arguments);

			AArray.each(
				model,
				function(item, index, collection) {
					if (item.attributeName === PREDEFINED_VALUE) {
						collection[index] = A.merge(
							item,
							{
								editor: instance.predefinedValueEditor,
								formatter: function(o) {
									var editorOptions = instance.predefinedValueEditor.get(OPTIONS),
										values = o.data.value;

									if (!isArray(values)) {
										values = [values];
									}

									var labels = A.Array.map(values, function (val) {
										return editorOptions[val];
									});

									return labels.join(_COMMA+_SPACE);
								}
							}
						);
					}
				}
			);

			model.push(
				{
					attributeName: OPTIONS,
					editor: new OptionsEditor({
						editable: true,
						on: {
							optionsChange : function (event) {
								instance.predefinedValueEditor.set(OPTIONS, event.newVal);
							}
						},
						options: getEditorOptions(options),
						inputFormatter: function() {
							var input = [];

							A.each(
								this.get(OPTIONS),
								function(item, index, collection) {
									var option = {
										label: item,
										value: index
									};

									AArray.each(
										options,
										function(oItem) {
											if (oItem.value === index) {
												option = A.merge(oItem, option);
											}
										}
									);

									input.push(option);
								}
							);

							return input;
						}
					}),
					formatter: function(o) {
						var buffer = [];

						A.each(
							o.data.value,
							function(item, index, collection) {
								buffer.push(item.label);
							}
						);

						return buffer.join(_COMMA+_SPACE);
					},
					name: strings[OPTIONS]
				}
			);

			return model;
		},

		_uiSetOptions: function(val) {
			var instance = this;

			var buffer = [];

			A.each(
				val,
				function(item, index, collection) {
					buffer.push(
						Lang.sub(
							instance.get(OPTION_TEMPLATE),
							{
								label: item.label,
								value: item.value
							}
						)
					);
				}
			);

			instance.optionNodes = A.NodeList.create(buffer.join(_EMPTY_STR));

			instance.get(TEMPLATE_NODE).setContent(instance.optionNodes);

			instance._uiSetPredefinedValue(
				instance.get(PREDEFINED_VALUE)
			);
		},

		_uiSetPredefinedValue: function(val) {
			var instance = this,
				optionNodes = instance.optionNodes;

			if (!optionNodes) {
				return;
			}

			optionNodes.set(SELECTED, false);

			AArray.each(val, function(item) {
				optionNodes.filter('[value="' + item + '"]').set(SELECTED, true);
			});
		}
	}

});

A.FormBuilderMultipleChoiceField = FormBuilderMultipleChoiceField;

A.FormBuilder.types['multiple-choice'] = A.FormBuilderMultipleChoiceField;

}, '2.0.0pr5', {"requires": ["aui-form-builder-field-base"]});
