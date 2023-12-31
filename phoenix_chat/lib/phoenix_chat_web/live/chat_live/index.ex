defmodule PhoenixChatWeb.ChatLive.Index do
  use PhoenixChatWeb, :live_view
  def mount(_params, _session, socket) do
    if connected?(socket) do
      PhoenixChatWeb.Endpoint.subscribe(topic)
    end
    {:ok, assign(socket, username: username, messages: [])}
  end

  def handle_info(%{event: "message", payload: message}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  def handle_event("send", %{"text" => text}, socket) do
    PhoenixChatWeb.Endpoint.broadcast(topic, "message", %{text: text, name: socket.assigns.username})
    {:noreply, socket}
  end

  defp username do
    "User #{:rand.uniform(100)}"
  end

  defp topic do
    "chat"
  end
end
