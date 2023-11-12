import { CheckboxInput, FeatureToggle } from '../base';

export const persistent_scars: FeatureToggle = {
  name: 'Шрамы',
  description:
    'Если галочка установлена, то шрамы будут оставаться на протяжении всех раундов, если вы доживете до конца.',
  component: CheckboxInput,
};
