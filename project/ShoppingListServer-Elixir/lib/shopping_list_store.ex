##############################################################################
# Assignment : 5
# Author     : Lishan Huang
# Email      : lhuan22@uwo.ca
# 
# The ShoppingListStore module manages shopping lists for users. 
##############################################################################
defmodule ShoppingListStore do
  # Path to the shopping list files (db/lists/*)
  # Don't forget to create this directory if it doesn't exist
  @database_directory Path.join("db", "lists")

  # Note: you will spawn a process to run this store in
  # ShoppingListServer.  You do not need to spawn another process here
  def start() do
    # Call your receive loop
    loop()
    
  end

  defp loop() do

    receive do
      #define the receive formular of clear function
      {caller, :clear} ->
        _clear(caller)
        loop()
      #define the receive formular of list function
      {caller, :list, username} ->
        list(caller, username)
        loop()
      #define the receive formular of add function
      {caller, :add, username, item} ->
        add(caller, username, item)
        loop()
      #define the receive formular of delete function
      {caller, :delete, username, item} ->
        delete(caller, username, item)
        loop()
      #define the receive formular of exit function
      {caller, :exit} ->
        _exit(caller)
      # Always handle unmatched messages
      # Otherwise, they queue indefinitely
      _ ->
        loop()
    end

  end
  #Loads the user's shopping list from db/lists/USERNAME.txt
  def list(caller,username) do
    #if target user does not exist then create a neew file for this user
    if(File.exists?(user_db(username)) == false) do  
      File.mkdir_p(@database_directory)
      File.touch!(user_db(username))
    end
    #read the line in this file
    stream= File.stream!(user_db(username))
    #read line by line into a list and store in content
    content = stream \
      |> Enum.map(&String.trim/1) 
    #send return message with username and content
    send(caller, {self(), :list, username, content})
  end


#add item to a specific user
  def add(caller,username, item) do
    #if user does not exist then create a file for this user
    if(File.exists?(user_db(username)) == false) do  
      File.mkdir_p(@database_directory)
      File.touch!(user_db(username))
    end
    #read the file and store in content
    stream= File.stream!(user_db(username))
    content = stream \
      |> Enum.map(&String.trim/1) 
      #if the item does not already exist in the user's list,
      #add the new item to content and sort it then join \n to spliti into different line again
    if (Enum.member?(content, item) == false) do
        content= content ++ [item] \
        |>Enum.sort() \
        |>Enum.join("\n")
        File.write(user_db(username), content)
        #send return message with :add usernam and item
        send(caller,{self(),:added,username,item})
    else
      #send return message with :exists usernam and item
        send(caller, {self(),:exists, username, item})
    end
        
  end

  
  @spec delete(any(), any(), any()) :: any()
  #delete user's item 
  def delete(caller, username, item) do
    #if user does not exist then return not found
    if(File.exists?(user_db(username)) == false) do  
      send(caller, {self(),:not_found ,username, item})
    else
      #if user exist then load the item from user's list into content
    stream= File.stream!(user_db(username))
    content = stream \
      |> Enum.map(&String.trim/1) 
      #remove the target content and sort it add \n to split into different line  again
      if (Enum.member?(content, item) == true) do
        content= content -- [item] \
        |>Enum.sort() \
        |>Enum.join("\n")
        #write content into the file and cover the old content
        File.write(user_db(username), content)
        #send back message :delete if deleted successfully
        send(caller,{self(),:deleted,username,item})
    else
      #send back message :not_found if fail to delete it
        send(caller, {self(),:not_found ,username, item})
    end
  end
  end

  # Implemented for you
  #clear the shopping list file
  def _clear(caller) do
    #remove the file 
    File.rm_rf @database_directory
    #send back message if rm successfully
    send(caller, {self(), :cleared})
  end

  # Path to the shopping list file for the specified user
  # (db/lists/USERNAME.txt)
  defp user_db(username), do: Path.join(@database_directory, "#{username}.txt")
  #shut down the process
  defp _exit(caller), do: IO.puts ("ShoppingListStore shutting down")

  
end
