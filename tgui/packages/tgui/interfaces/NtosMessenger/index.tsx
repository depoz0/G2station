import { Box, Button, Icon, Section, Stack, Input, TextArea, Dimmer, Divider } from '../../components';
import { useBackend, useLocalState } from '../../backend';
import { createSearch } from 'common/string';
import { BooleanLike } from 'common/react';
import { NtosWindow } from '../../layouts';

import { NtChat, NtMessenger, NtPicture } from './types';
import { ChatScreen } from './ChatScreen';
import { sortBy } from 'common/collections';

type NtosMessengerData = {
  can_spam: BooleanLike;
  is_silicon: BooleanLike;
  owner?: NtMessenger;
  saved_chats: Record<string, NtChat>;
  messengers: Record<string, NtMessenger>;
  sort_by_job: BooleanLike;
  alert_silenced: BooleanLike;
  alert_able: BooleanLike;
  sending_and_receiving: BooleanLike;
  open_chat: string;
  stored_photos?: NtPicture[];
  selected_photo_path?: string;
  on_spam_cooldown: BooleanLike;
  virus_attach: BooleanLike;
  sending_virus: BooleanLike;
};

export const NtosMessenger = (props) => {
  const { data } = useBackend<NtosMessengerData>();
  const {
    is_silicon,
    saved_chats,
    stored_photos,
    selected_photo_path,
    open_chat,
    messengers,
    sending_virus,
  } = data;

  let content: JSX.Element;
  if (open_chat !== null) {
    const openChat = saved_chats[open_chat];
    const temporaryRecipient = messengers[open_chat];

    if (!openChat && !temporaryRecipient) {
      content = <ContactsScreen />;
    } else {
      content = (
        <ChatScreen
          storedPhotos={stored_photos}
          selectedPhoto={selected_photo_path}
          isSilicon={is_silicon}
          sendingVirus={sending_virus}
          canReply={openChat ? openChat.can_reply : !!temporaryRecipient}
          messages={openChat ? openChat.messages : []}
          recipient={openChat ? openChat.recipient : temporaryRecipient}
          unreads={openChat ? openChat.unread_messages : 0}
          chatRef={openChat?.ref}
        />
      );
    }
  } else {
    content = <ContactsScreen />;
  }

  return (
    <NtosWindow width={600} height={850}>
      <NtosWindow.Content>{content}</NtosWindow.Content>
    </NtosWindow>
  );
};

const ContactsScreen = (props: any) => {
  const { act, data } = useBackend<NtosMessengerData>();
  const {
    owner,
    alert_silenced,
    alert_able,
    sending_and_receiving,
    saved_chats,
    messengers,
    sort_by_job,
    can_spam,
    is_silicon,
    virus_attach,
    sending_virus,
  } = data;

  const [searchUser, setSearchUser] = useLocalState('searchUser', '');

  const sortByUnreads = sortBy<NtChat>((chat) => chat.unread_messages);

  const searchChatByName = createSearch(
    searchUser,
    (chat: NtChat) => chat.recipient.name + chat.recipient.job
  );
  const searchMessengerByName = createSearch(
    searchUser,
    (messenger: NtMessenger) => messenger.name + messenger.job
  );

  const chatToButton = (chat: NtChat) => {
    return (
      <ChatButton
        key={chat.ref}
        name={`${chat.recipient.name} (${chat.recipient.job})`}
        chatRef={chat.ref}
        unreads={chat.unread_messages}
      />
    );
  };

  const messengerToButton = (messenger: NtMessenger) => {
    return (
      <ChatButton
        key={messenger.ref}
        name={`${messenger.name} (${messenger.job})`}
        chatRef={messenger.ref!}
        unreads={0}
      />
    );
  };

  const openChatsArray = sortByUnreads(Object.values(saved_chats)).filter(
    searchChatByName
  );

  const filteredChatButtons = openChatsArray
    .filter((c) => c.visible)
    .map(chatToButton);

  const messengerButtons = Object.entries(messengers)
    .filter(
      ([ref, messenger]) =>
        openChatsArray.every((chat) => chat.recipient.ref !== ref) &&
        searchMessengerByName(messenger)
    )
    .map(([_, messenger]) => messenger)
    .map(messengerToButton)
    .concat(openChatsArray.filter((chat) => !chat.visible).map(chatToButton));

  const noId = !owner && !is_silicon;

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <Stack vertical textAlign="center">
            <Box bold>
              <Icon name="address-card" mr={1} />
              SpaceMessenger V6.5.3
            </Box>
            <Box italic opacity={0.3} mt={1}>
              Защищаем вас от шпионажа с 2467 года.
            </Box>
            <Divider hidden />
            <Box>
              <Button
                icon="bell"
                disabled={!alert_able}
                content={
                  alert_able && !alert_silenced ? 'Звонок: Вкл' : 'Звонок: Выкл'
                }
                onClick={() => act('PDA_toggleAlerts')}
              />
              <Button
                icon="address-card"
                content={
                  sending_and_receiving
                    ? 'Отправка / Получение: Вкл'
                    : 'Отправка / Получение: Выкл'
                }
                onClick={() => act('PDA_toggleSendingAndReceiving')}
              />
              <Button
                icon="bell"
                content="Рингтон"
                onClick={() => act('PDA_ringSet')}
              />
              <Button
                icon="sort"
                content={`Сортировка: ${sort_by_job ? 'Дол' : 'Имя'}`}
                onClick={() => act('PDA_changeSortStyle')}
              />
              {!!virus_attach && (
                <Button
                  icon="bug"
                  color="bad"
                  content={`Прикрепить вирус: ${sending_virus ? 'Да' : 'Нет'}`}
                  onClick={() => act('PDA_toggleVirus')}
                />
              )}
            </Box>
          </Stack>
          <Divider hidden />
          <Stack justify="space-between">
            <Box m={0.5}>
              <Icon name="magnifying-glass" mr={1} />
              Поиск пользователя
            </Box>
            <Input
              width="220px"
              placeholder="Поиск по имени или должности..."
              value={searchUser}
              onInput={(_: any, value: string) => setSearchUser(value)}
            />
          </Stack>
        </Section>
      </Stack.Item>
      {filteredChatButtons.length > 0 && (
        <Stack.Item grow={1}>
          <Stack vertical fill>
            <Section>
              <Icon name="comments" mr={1} />
              Предыдущие сообщения
            </Section>
            <Section fill scrollable>
              <Stack vertical>{filteredChatButtons}</Stack>
            </Section>
          </Stack>
        </Stack.Item>
      )}
      <Stack.Item grow={2}>
        <Stack vertical fill>
          <Section>
            <Stack>
              <Box m={0.5}>
                <Icon name="address-card" mr={1} />
                Detected Messengers
              </Box>
            </Stack>
          </Section>
          <Section fill scrollable>
            <Stack vertical pb={1} fill>
              {messengerButtons.length === 0 && (
                <Stack align="center" justify="center" fill pl={4}>
                  <Icon color="gray" name="user-slash" size={2} />
                  <Stack.Item fontSize={1.5} ml={3}>
                    Пользователи не найдены.
                  </Stack.Item>
                </Stack>
              )}
              {messengerButtons}
            </Stack>
          </Section>
        </Stack>
      </Stack.Item>
      {!!can_spam && (
        <Stack.Item>
          <SendToAllSection />
        </Stack.Item>
      )}
      {noId && <NoIDDimmer />}
    </Stack>
  );
};

type ChatButtonProps = {
  name: string;
  unreads: number;
  chatRef: string;
};

const ChatButton = (props: ChatButtonProps) => {
  const { act } = useBackend();
  const unreadMessages = props.unreads;
  const hasUnreads = unreadMessages > 0;
  return (
    <Button
      icon={hasUnreads && 'envelope'}
      key={props.chatRef}
      fluid
      onClick={() => {
        act('PDA_viewMessages', { ref: props.chatRef });
      }}>
      {hasUnreads &&
        `[${unreadMessages <= 9 ? unreadMessages : '9+'} unread message${
          unreadMessages !== 1 ? 's' : ''
        }]`}{' '}
      {props.name}
    </Button>
  );
};

const SendToAllSection = (props) => {
  const { data, act } = useBackend<NtosMessengerData>();
  const { on_spam_cooldown } = data;

  const [message, setmessage] = useLocalState('everyoneMessage', '');

  return (
    <>
      <Section>
        <Stack justify="space-between">
          <Stack.Item align="center">
            <Icon name="satellite-dish" mr={1} ml={0.5} />
            Отправить всем
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="arrow-right"
              disabled={on_spam_cooldown || message === ''}
              tooltip={
                on_spam_cooldown && 'Подождите перед отправкой новых сообщений!'
              }
              tooltipPosition="auto-start"
              onClick={() => {
                act('PDA_sendEveryone', { message: message });
                setmessage('');
              }}>
              Отправить
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
      <Section>
        <TextArea
          height={6}
          value={message}
          placeholder="Отправить сообщение всем..."
          onInput={(_: any, v: string) => setmessage(v)}
        />
      </Section>
    </>
  );
};

const NoIDDimmer = () => {
  return (
    <Dimmer>
      <Stack align="baseline" vertical>
        <Stack ml={-2}>
          <Icon color="red" name="address-card" size={10} />
        </Stack>
        <Stack.Item fontSize="18px">
          Для продолжения сделайте снимок ID.
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};
