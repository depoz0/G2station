import { NoteKeeper } from './NoteKeeper';
import {
  Stack,
  Section,
  NoticeBox,
  Box,
  LabeledList,
  Button,
  RestrictedInput,
} from 'tgui/components';
import { CharacterPreview } from '../common/CharacterPreview';
import { getMedicalRecord, getQuirkStrings } from './helpers';
import { useBackend } from '../../backend';
import {
  PHYSICALSTATUS2COLOR,
  PHYSICALSTATUS2DESC,
  PHYSICALSTATUS2ICON,
  MENTALSTATUS2COLOR,
  MENTALSTATUS2DESC,
  MENTALSTATUS2ICON,
} from './constants';
import { MedicalRecordData } from './types';
import { EditableText } from '../common/EditableText';

/** Views a selected record. */
export const MedicalRecordView = (props) => {
  const foundRecord = getMedicalRecord();
  if (!foundRecord) return <NoticeBox>No record selected.</NoticeBox>;

  const { act, data } = useBackend<MedicalRecordData>();
  const { assigned_view, physical_statuses, mental_statuses, station_z } = data;

  const { min_age, max_age } = data;

  const {
    age,
    blood_type,
    crew_ref,
    dna,
    gender,
    major_disabilities,
    minor_disabilities,
    physical_status,
    mental_status,
    name,
    quirk_notes,
    rank,
    species,
  } = foundRecord;

  const minor_disabilities_array = getQuirkStrings(minor_disabilities);
  const major_disabilities_array = getQuirkStrings(major_disabilities);
  const quirk_notes_array = getQuirkStrings(quirk_notes);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <CharacterPreview height="100%" id={assigned_view} />
          </Stack.Item>
          <Stack.Item grow>
            <NoteKeeper />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Section
          buttons={
            <Button.Confirm
              content="Удалить"
              icon="trash"
              disabled={!station_z}
              onClick={() => act('expunge_record', { crew_ref: crew_ref })}
              tooltip="Удалить данные о записях."
            />
          }
          fill
          scrollable
          title={name}
          wrap
        >
          <LabeledList>
            <LabeledList.Item label="Имя">
              <EditableText field="name" target_ref={crew_ref} text={name} />
            </LabeledList.Item>
            <LabeledList.Item label="Работа">
              <EditableText field="job" target_ref={crew_ref} text={rank} />
            </LabeledList.Item>
            <LabeledList.Item label="Возраст">
              <RestrictedInput
                minValue={min_age}
                maxValue={max_age}
                onEnter={(event, value) =>
                  act('edit_field', {
                    field: 'age',
                    ref: crew_ref,
                    value: value,
                  })
                }
                value={age}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Вид">
              <EditableText
                field="species"
                target_ref={crew_ref}
                text={species}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Пол">
              <EditableText
                field="gender"
                target_ref={crew_ref}
                text={gender}
              />
            </LabeledList.Item>
            <LabeledList.Item label="ДНК">
              <EditableText
                color="good"
                field="dna"
                target_ref={crew_ref}
                text={dna}
              />
            </LabeledList.Item>
            <LabeledList.Item color="bad" label="Группа крови">
              <EditableText
                field="blood_type"
                target_ref={crew_ref}
                text={blood_type}
              />
            </LabeledList.Item>
            <LabeledList.Item
              buttons={physical_statuses.map((button, index) => {
                const isSelected = button === physical_status;
                return (
                  <Button
                    color={isSelected ? PHYSICALSTATUS2COLOR[button] : 'grey'}
                    height={'1.75rem'}
                    icon={PHYSICALSTATUS2ICON[button]}
                    key={index}
                    onClick={() =>
                      act('set_physical_status', {
                        crew_ref: crew_ref,
                        physical_status: button,
                      })
                    }
                    textAlign="center"
                    tooltip={PHYSICALSTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                    width={!isSelected ? '3.0rem' : 3.0}
                  >
                    {button[0]}
                  </Button>
                );
              })}
              label="Физическое состояние"
            >
              <Box color={PHYSICALSTATUS2COLOR[physical_status]}>
                {physical_status}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item
              buttons={mental_statuses.map((button, index) => {
                const isSelected = button === mental_status;
                return (
                  <Button
                    color={isSelected ? MENTALSTATUS2COLOR[button] : 'grey'}
                    height={'1.75rem'}
                    icon={MENTALSTATUS2ICON[button]}
                    key={index}
                    onClick={() =>
                      act('set_mental_status', {
                        crew_ref: crew_ref,
                        mental_status: button,
                      })
                    }
                    textAlign="center"
                    tooltip={MENTALSTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                    width={!isSelected ? '3.0rem' : 3.0}
                  >
                    {button[0]}
                  </Button>
                );
              })}
              label="Психическое состояние"
            >
              <Box color={MENTALSTATUS2COLOR[mental_status]}>
                {mental_status}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Minor Disabilities">
              {minor_disabilities_array.map((disability, index) => (
                <Box key={index}>&#8226; {disability}</Box>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Major Disabilities">
              {major_disabilities_array.map((disability, index) => (
                <Box key={index}>&#8226; {disability}</Box>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Quirks">
              {quirk_notes_array.map((quirk, index) => (
                <Box key={index}>&#8226; {quirk}</Box>
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
