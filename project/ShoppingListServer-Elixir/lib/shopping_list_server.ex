##############################################################################
# Assignment : 5
# Author     : Lishan Huang
# Email      : lhuan22@uwo.ca
# 
# The ShoppingListServer module implements a shopping list server,
# handling requests from clients and making use of the ShoppingListStore and UserStore to read and write data
##############################################################################
#import User,ShoppingListStore,UserStore modules
import ShoppingListStore
import User
import UserStore
defmodule ShoppingListServer do
  #define the path of database's directory and user's database
  @database_directory Path.join("db", "lists")
  @user_database Path.join("db", "users.txt")

  def start() do
    
    # Spawn a linked UserStore process
    users_pid = spawn(UserStore, :start , []) 
    # Spawn a linked ShoppingListStore process
    lists_pid = spawn(ShoppingListStore, :start, [])
    # Leave this here
    Process.register(self(), :server)  
    # Start the message processing loop 
    loop(users_pid, lists_pid)

  end

  def loop(users, lists) do
    # Receive loop goes here
    #
    # For each request that is received, you MUST spawn a new process
    # to handle it (either here, or in a helper method) so that the main
    # process can immediately return to processing incoming messages
    #
    # Note: use helper functions.  Implementing everything in a massive
    # function here will lose you marks.
    receive do
      {caller,:new_user,username, password} ->
        new_user(caller,users, lists,username, password)

        loop(users, lists)

      {caller,:list_users} ->
        list_users( caller,users, lists)

        loop(users, lists)

      {caller,:shopping_list,username, password} ->
        shopping_list(caller,users, lists,username, password)

        loop(users, lists)
        
      {caller,:add_item,username, password,item} ->
        add_item(caller,users, lists,username, password,item)
 
        loop(users, lists)

      {caller,:delete_item,username, password,item} ->
        delete_item(caller,users, lists,username, password,item)

        loop(users, lists)

      {caller, :clear} ->
        clear(caller,users, lists)
        loop(users, lists)

      {caller, :exit} ->
        _exit(caller,users, lists)

      _ ->
        loop(users, lists)
    end
  end
  #Sends a message to the UserStore process to add a new user
  def new_user(caller,users, lists,username, password) do
    #spawn the a process of UserStore

    # Spawn a linked ShoppingListStore process
    #send message to add user into user's list
    message = send(users,{self(),UserStore.add( users ,username,password)})
    #if the return message is "User already exists" then send error 
    case message do
      {pid,{pid,:error, "User already exists"}} ->
        send(caller,{self(), :error, "User already exists"})
#if the return message is "User created successfully then send successfully
      {pid,{pid, :added, %User{}}}->
        send(caller,{self(), :ok, "User created successfully"})
#other return message send eroor with An unknown error occurred"
      _ ->send(caller,{self(), :error, "An unknown error occurred",message})
    end
   
  end
#Sends a message to the UserStore process to get a sorted list of usernames
  def list_users(caller,users, lists) do
    #spawn a process of userstore
    #send message to the above process and list the useer's list
    message = send(users,{self(),UserStore.list(self())})
    case message do
      #if the return message is correct then send ok
      {pid, {pid, :user_list, name}} ->
        send(caller,{self(), :ok, name})
        #else send error
      _->
        send(caller,{self(), :error, "An unknown error occurred"})
      end
  end
  #Sends a message to the UserStore process to authenticate the user
  def shopping_list(caller,users, lists, username, password) do
    #spawn process of userstore and shoppingliststore
  
    #send message to users and process authenticate with username,password
    message = send(users,{self(),UserStore.authenticate(users,username,password)})
    case message do
      #if return message is  fail then return error
      {pid,{pid, :auth_failed, username}} ->
        send(caller,{self(), :error, "Authentication failed"})
        #if success then send message to ShoppingListStore to list the item of this user
      {pid,{pid,:auth_success, username}} ->
        message2 = send(lists,{self(),ShoppingListStore.list(lists ,username)})
        #if the list item process return success then return ok
        case message2 do
          {pid,{pid,:list, username, content}} ->
            send(caller,{self(),:ok, content})
            #otherwise return error
          _->
            send(caller,{self(), :error, "An unknown error occurred"})
        end
        
    end
    
  end
  #Sends a message to the UserStore process to authenticate the user
  def add_item(caller,users, lists,username, password, item) do
    #spawn process of UserStore and ShoppingListStore 
    
    #send message to UserStore and check whether username and password correct or not
    message = send(users,{self(),UserStore.authenticate(users,username,password)})
    case message do
      #if message return fail then return error
      {pid,{pid, :auth_failed, username}} ->
        send(caller,{self(),:error,"Authentication failed"})
        #if success the process ShoppingListStore to add item
      {pid,{pid,:auth_success, username}} ->  
        message2 = send(lists, {self(),ShoppingListStore.add(lists,username, item)})
        case message2 do
          #if add success then return ok and the message with item s
          {pid,{pid, :added, username,item}} ->
          send(caller,{self(),:ok, "Item '#{item}' added to shopping list"})
          #if fail and return message show already existed then return error with message o already eixsts
          {pid,{pid,:exists, username, item}} ->
            send(caller,{self(),:error, "Item '#{item}' already exists"})
            #otherwise return error with unkonw error
          _->
            send(caller,{self(), :error, "An unknown error occurred"})
          end
          #otherwise return error with unkonw error
      _->
        send(caller,{self(), :error, "An unknown error occurred"})  
      end
  end
  #Sends a message to the UserStore process to authenticate the user
  def delete_item(caller,users, lists, username, password, item)do
     #spawn process of UserStore and ShoppingListStore 
   
    #send message to UserStore and check whether username and password correct or not
    message = send(users,{self(),UserStore.authenticate(users,username,password)})
    case message do
       #if message return fail then return error
      {pid,{pid, :auth_failed, username}} ->
        send(caller,{self(),:error,"Authentication failed"})
      {pid,{pid,:auth_success, username}} ->  
        #if it success then send message to delete item
        message2 = send(lists, {self(),ShoppingListStore.delete(caller, username, item)})
        case message2 do
          #if the return message is deleted then return ok with message of the item
          {pid,{pid,:deleted,username,item}} ->
            send(caller,{self(), :ok, "Item '#{item}' deleted from shopping list"})
            #if if not found then return error with item not found
          {pid,{pid,:not_found ,username, item}} ->
            send(caller,{self(), :error,"Item '#{item}' not found"})
            #else return error with unknown error
          _->
            send(caller,{self(), :error, "An unknown error occurred"})
         end
         #else return error with unknown error
      _->
        send(caller,{self(), :error, "An unknown error occurred"})
      end

  end
  def clear(caller,users, lists) do
    #remove userdatabsed and databsed directory
    message1 =  send(users,{self(),UserStore._clear(caller)})
    message2 =  send(lists,{self(),ShoppingListStore._clear(caller)})
    case message1 do
    {pid,{pid,:cleared}} ->
      case message2 do
        {pid,{pid,:cleared}} ->
         send(caller, {self(), :ok, "All data cleared"})
        _->
          send(caller, {self(), :error, "An unknown error occurred"})
      end
    _->
      send(caller, {self(), :error, "An unknown error occurred"})
    end

    
  end
  #shut down the process
  defp _exit(caller,users, lists), do: IO.puts ("ShoppingListServer shutting down") 
  

end
