import {
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureColorInput,
  FeatureDropdownInput,
  FeatureValueProps,
} from './base';

export const eye_color: Feature<string> = {
  name: 'Цвет глаз',
  component: FeatureColorInput,
};

export const facial_hair_color: Feature<string> = {
  name: 'Цвет волос на лице',
  component: FeatureColorInput,
};

export const facial_hair_gradient: FeatureChoiced = {
  name: 'Градиент волос на лице',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const facial_hair_gradient_color: Feature<string> = {
  name: 'Цвет градиента волос на лице',
  component: FeatureColorInput,
};

export const hair_color: Feature<string> = {
  name: 'Цвет волос',
  component: FeatureColorInput,
};

export const hair_gradient: FeatureChoiced = {
  name: 'Градиент для волос',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const hair_gradient_color: Feature<string> = {
  name: 'Цвет градиента волос',
  component: FeatureColorInput,
};

export const feature_human_ears: FeatureChoiced = {
  name: 'Уши',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_human_tail: FeatureChoiced = {
  name: 'Хвост',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_legs: FeatureChoiced = {
  name: 'Ноги',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_spines: FeatureChoiced = {
  name: 'Позвоночник',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_tail: FeatureChoiced = {
  name: 'Хвост',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_mcolor: Feature<string> = {
  name: 'Цвет мутанта',
  component: FeatureColorInput,
};

export const underwear_color: Feature<string> = {
  name: 'Цвет нижнего белья',
  component: FeatureColorInput,
};

export const feature_vampire_status: Feature<string> = {
  name: 'Vampire status',
  component: FeatureDropdownInput,
};

export const heterochromatic: Feature<string> = {
  name: 'Гетерохроматический (правый глаз) цвет',
  component: FeatureColorInput,
};
