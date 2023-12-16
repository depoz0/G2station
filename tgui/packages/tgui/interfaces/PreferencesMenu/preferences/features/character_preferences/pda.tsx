import {
  Feature,
  FeatureChoiced,
  FeatureDropdownInput,
  FeatureShortTextInput,
} from '../base';

export const pda_theme: FeatureChoiced = {
  name: 'PDA Тема',
  category: 'GAMEPLAY',
  component: FeatureDropdownInput,
};

export const pda_ringtone: Feature<string> = {
  name: 'PDA Рингтон',
  component: FeatureShortTextInput,
};
