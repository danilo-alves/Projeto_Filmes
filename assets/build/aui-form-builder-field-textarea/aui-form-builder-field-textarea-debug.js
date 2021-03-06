YUI.add('aui-form-builder-field-textarea', function (A, NAME) {

var L = A.Lang,

	AArray = A.Array,

	FIELD = 'field',
	FORM_BUILDER_FIELD = 'form-builder-field',
	FORM_BUILDER_TEXTAREA_FIELD = 'form-builder-textarea-field',
	NODE = 'node',
	PREDEFINED_VALUE = 'predefinedValue',
	SPACE = ' ',
	TEXT = 'text',
	TEXTAREA = 'textarea',

	getCN = A.getClassName,

	CSS_FIELD = getCN(FIELD),
	CSS_FIELD_TEXT = getCN(FIELD, TEXT),
	CSS_FIELD_TEXTAREA = getCN(FIELD, TEXTAREA),
	CSS_FORM_BUILDER_FIELD = getCN(FORM_BUILDER_FIELD),
	CSS_FORM_BUILDER_FIELD_NODE = getCN(FORM_BUILDER_FIELD, NODE),

	TPL_TEXTAREA = '<textarea id="{id}" class="' + [CSS_FORM_BUILDER_FIELD_NODE, CSS_FIELD, CSS_FIELD_TEXT, CSS_FIELD_TEXTAREA].join(SPACE) + '" name="{name}">{value}</textarea>';

var FormBuilderTextAreaField = A.Component.create({

	NAME: FORM_BUILDER_TEXTAREA_FIELD,

	ATTRS: {

		template: {
			valueFn: function() {
				return TPL_TEXTAREA;
			}
		}

	},

	CSS_PREFIX: CSS_FORM_BUILDER_FIELD,

	EXTENDS: A.FormBuilderTextField,

	prototype: {

		getPropertyModel: function() {
			var instance = this;

			var model = A.FormBuilderTextAreaField.superclass.getPropertyModel.apply(instance, arguments);

			AArray.each(
				model,
				function(item, index, collection) {
					if (item.attributeName === PREDEFINED_VALUE) {
						collection[index].editor = new A.TextAreaCellEditor();
					}
				}
			);

			return model;
		}

	}

});

A.FormBuilderTextAreaField = FormBuilderTextAreaField;

A.FormBuilder.types.textarea = A.FormBuilderTextAreaField;


}, '2.0.0pr5', {"requires": ["aui-form-builder-field-base"]});
