import { classes } from 'common/react';

import { Icon } from '../../components';

const MATERIAL_ICONS: Record<string, [number, string][]> = {
  железо: [
    [0, 'sheet-metal'],
    [17, 'sheet-metal_2'],
    [34, 'sheet-metal_3'],
  ],
  стекло: [
    [0, 'sheet-glass'],
    [17, 'sheet-glass_2'],
    [34, 'sheet-glass_3'],
  ],
  серебро: [
    [0, 'sheet-silver'],
    [17, 'sheet-silver_2'],
    [34, 'sheet-silver_3'],
  ],
  золото: [
    [0, 'sheet-gold'],
    [17, 'sheet-gold_2'],
    [34, 'sheet-gold_3'],
  ],
  алмаз: [
    [0, 'sheet-diamond'],
    [17, 'sheet-diamond_2'],
    [34, 'sheet-diamond_3'],
  ],
  плазма: [
    [0, 'sheet-plasma'],
    [17, 'sheet-plasma_2'],
    [34, 'sheet-plasma_3'],
  ],
  уран: [
    [0, 'sheet-uranium'],
    [17, 'sheet-uranium_2'],
    [34, 'sheet-uranium_3'],
  ],
  бананиум: [
    [0, 'sheet-bananium'],
    [17, 'sheet-bananium_2'],
    [34, 'sheet-bananium_3'],
  ],
  титан: [
    [0, 'sheet-titanium'],
    [17, 'sheet-titanium_2'],
    [34, 'sheet-titanium_3'],
  ],
  'bluespace crystal': [[0, 'bluespace_crystal']],
  пластик: [
    [0, 'sheet-plastic'],
    [17, 'sheet-plastic_2'],
    [34, 'sheet-plastic_3'],
  ],
};

export type MaterialIconProps = {
  /**
   * The name of the material.
   */
  materialName: string;

  /**
   * The number of sheets of the material.
   */
  sheets?: number;
};

/**
 * A 32x32 material icon. Animates between different stack sizes of the given
 * material.
 */
export const MaterialIcon = (props: MaterialIconProps) => {
  const { materialName, sheets = 0 } = props;
  const icons = MATERIAL_ICONS[materialName];

  if (!icons) {
    return <Icon name="question-circle" />;
  }

  let activeIdx = 0;

  while (icons[activeIdx + 1] && icons[activeIdx + 1][0] <= sheets) {
    activeIdx += 1;
  }

  return (
    <div className={'FabricatorMaterialIcon'}>
      {icons.map(([_, iconState], idx) => (
        <div
          key={idx}
          className={classes([
            'FabricatorMaterialIcon__Icon',
            idx === activeIdx && 'FabricatorMaterialIcon__Icon--active',
            'sheetmaterials32x32',
            iconState,
          ])}
        />
      ))}
    </div>
  );
};
