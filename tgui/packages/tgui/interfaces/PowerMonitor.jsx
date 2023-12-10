import { map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { toFixed } from 'common/math';
import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Chart,
  ColorBox,
  Flex,
  Icon,
  LabeledList,
  ProgressBar,
  Section,
  Table,
  Dimmer,
  Stack,
} from '../components';
import { Window } from '../layouts';

const PEAK_DRAW = 500000;

export const powerRank = (str) => {
  const unit = String(str.split(' ')[1]).toLowerCase();
  return ['w', 'kw', 'mw', 'gw'].indexOf(unit);
};

export const PowerMonitor = () => {
  return (
    <Window width={550} height={700}>
      <Window.Content scrollable>
        <PowerMonitorContent />
      </Window.Content>
    </Window>
  );
};

export const PowerMonitorContent = (props) => {
  const { data } = useBackend();
  const { history = { supply: [], demand: [] } } = data;
  const [sortByField, setSortByField] = useLocalState('sortByField', null);
  const supply = history.supply[history.supply.length - 1] || 0;
  const demand = history.demand[history.demand.length - 1] || 0;
  const supplyData = history.supply.map((value, i) => [i, value]);
  const demandData = history.demand.map((value, i) => [i, value]);
  const maxValue = Math.max(PEAK_DRAW, ...history.supply, ...history.demand);
  // Process area data
  const areas = flow([
    map((area, i) => ({
      ...area,
      // Generate a unique id
      id: area.name + i,
    })),
    sortByField === 'name' && sortBy((area) => area.name),
    sortByField === 'charge' && sortBy((area) => -area.charge),
    sortByField === 'draw' &&
      sortBy(
        (area) => -powerRank(area.load),
        (area) => -parseFloat(area.load),
      ),
  ])(data.areas);
  return (
    <>
      {areas.length === 0 && (
        <Dimmer>
          <Stack>
            <Stack.Item>
              <Icon name="plug-circle-exclamation" size={2} />
            </Stack.Item>
            <Stack.Item>
              <h1>ЛКП не найдены!</h1>
            </Stack.Item>
          </Stack>
        </Dimmer>
      )}
      <Flex mx={-0.5} mb={1}>
        <Flex.Item mx={0.5} width="200px">
          <Section>
            <LabeledList>
              <LabeledList.Item label="Производство">
                <ProgressBar
                  value={supply}
                  minValue={0}
                  maxValue={maxValue}
                  color="teal"
                >
                  {toFixed(supply / 1000) + ' кВ'}
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item label="Потребление">
                <ProgressBar
                  value={demand}
                  minValue={0}
                  maxValue={maxValue}
                  color="pink"
                >
                  {toFixed(demand / 1000) + ' кВ'}
                </ProgressBar>
              </LabeledList.Item>
            </LabeledList>
          </Section>
        </Flex.Item>
        <Flex.Item mx={0.5} grow={1}>
          <Section position="relative" height="100%" fill="true">
            <Chart.Line
              fillPositionedParent
              data={supplyData}
              rangeX={[0, supplyData.length - 1]}
              rangeY={[0, maxValue]}
              strokeColor="rgba(0, 181, 173, 1)"
              fillColor="rgba(0, 181, 173, 0.25)"
            />
            <Chart.Line
              fillPositionedParent
              data={demandData}
              rangeX={[0, demandData.length - 1]}
              rangeY={[0, maxValue]}
              strokeColor="rgba(224, 57, 151, 1)"
              fillColor="rgba(224, 57, 151, 0.25)"
            />
          </Section>
        </Flex.Item>
      </Flex>
      <Section>
        <Box mb={1}>
          <Box inline mr={2} color="label">
            Сортировать по:
          </Box>
          <Button.Checkbox
            checked={sortByField === 'name'}
            content="Название"
            onClick={() => setSortByField(sortByField !== 'name' && 'name')}
          />
          <Button.Checkbox
            checked={sortByField === 'charge'}
            content="Заряд"
            onClick={() => setSortByField(sortByField !== 'charge' && 'charge')}
          />
          <Button.Checkbox
            checked={sortByField === 'draw'}
            content="Потребление"
            onClick={() => setSortByField(sortByField !== 'draw' && 'draw')}
          />
        </Box>
        <Table>
          <Table.Row header>
            <Table.Cell>Area</Table.Cell>
            <Table.Cell collapsing>Charge</Table.Cell>
            <Table.Cell textAlign="right">Draw</Table.Cell>
            <Table.Cell collapsing title="Оборудование">
              Об
            </Table.Cell>
            <Table.Cell collapsing title="Свет">
              Св
            </Table.Cell>
            <Table.Cell collapsing title="Среда">
              Ср
            </Table.Cell>
          </Table.Row>
          {areas.map((area, i) => (
            <tr key={area.id} className="Table__row candystripe">
              <td>{area.name}</td>
              <td className="Table__cell text-right text-nowrap">
                <AreaCharge charging={area.charging} charge={area.charge} />
              </td>
              <td className="Table__cell text-right text-nowrap">
                {area.load}
              </td>
              <td className="Table__cell text-center text-nowrap">
                <AreaStatusColorBox status={area.eqp} />
              </td>
              <td className="Table__cell text-center text-nowrap">
                <AreaStatusColorBox status={area.lgt} />
              </td>
              <td className="Table__cell text-center text-nowrap">
                <AreaStatusColorBox status={area.env} />
              </td>
            </tr>
          ))}
        </Table>
      </Section>
    </>
  );
};

export const AreaCharge = (props) => {
  const { charging, charge } = props;
  return (
    <>
      <Icon
        width="18px"
        textAlign="center"
        name={
          (charging === 0 &&
            (charge > 50 ? 'battery-half' : 'battery-quarter')) ||
          (charging === 1 && 'bolt') ||
          (charging === 2 && 'battery-full')
        }
        color={
          (charging === 0 && (charge > 50 ? 'yellow' : 'red')) ||
          (charging === 1 && 'yellow') ||
          (charging === 2 && 'green')
        }
      />
      <Box inline width="36px" textAlign="right">
        {toFixed(charge) + '%'}
      </Box>
    </>
  );
};

const AreaStatusColorBox = (props) => {
  const { status } = props;
  const power = Boolean(status & 2);
  const mode = Boolean(status & 1);
  const tooltipText =
    (power ? 'Вкл' : 'Выкл') + ` [${mode ? 'авто' : 'мануал'}]`;
  return (
    <ColorBox
      color={power ? 'good' : 'bad'}
      content={mode ? undefined : 'M'}
      title={tooltipText}
    />
  );
};
