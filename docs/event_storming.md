# Business processes analyze via event storming
## Task Tracker
1. Таск-трекер должен быть отдельным дашбордом и доступен всем сотрудникам компании UberPopug Inc.  
    * Actor - User
    * Command - Show Dashboard
    * Data - Tasks + Developers ids
    * Event - TaskDashboard.Showed (maybe no events should be sent)

2. Авторизация в таск-трекере должна выполняться через общий сервис авторизации UberPopug Inc 
   (у нас там инновационная система авторизации на основе формы клюва).  
    * Actor - User
    * Command - Authenticate
    * Data - User id
    * Event - User.Authenticated

3. В таск-трекере должны быть только задачи. Проектов, скоупов и спринтов никому не надо, 
   ибо минимализм.  
    * Actor - ??
    * Command - ??
    * Data - ??
    * Event - ??

4. В таск-трекере новые таски может создавать кто угодно. У задачи должны быть описание, 
   статус (выполнена или нет) и попуг, на которого заассайнена задача.  
    * Actor - User
    * Command - Create task
    * Data - Task title, task description, user id
    * Event - Task.Created

5. Менеджеры или администраторы должны иметь кнопку «заассайнить задачи», которая возьмет все 
   открытые задачи и рандомно заассайнит каждую на любого из сотрудников. 
   Не успел закрыть задачу до реассайна — сорян, делай следующую.  
    * Actor - Manager
    * Command - Assign tasks
    * Data - Task ids, developer ids
    * Event - Task.Assigned (1 task assignment = 1 event)

6. Каждый сотрудник должен иметь возможность видеть в отдельном месте список заассайненных 
   на него задач + отметить задачу выполненной.
    * Actor - Developer
    * Command - Close task
    * Data - Task id, developer id
    * Event - Task.Closed
    
7. После ассайна новой задачи сотруднику должно приходить оповещение на почту, в слак и в смс. 
    * Actor - Task.Closed
    * Command - Send notification
    * Data - Task id, developer id
    * Event - Notification.Sent (SlackNotification.Sent, EmailNotification.Sent, 
      SMSNotification.Sent)

## Accounting
1. Аккаунтинг должен быть в отдельном дашборде и доступным только для администраторов и бухгалтеров
   * Actor - Authorized user (administrator/accountant)
   * Command - Show Dashboard
   * Data - N/A
   * Event - AccountingDashboard.Showed
   
2. Авторизация в таск-трекере должна выполняться через общий сервис аунтификации UberPopug Inc.
   * Actor - Any user
   * Command - Authorize via dedicated service
   * Data - User id
   * Event - User.Authorized
   
3. У каждого из сотрудников должен быть свой счет, который показывает, 
   сколько за сегодня он получил денег. У счета должен быть аудитлог того, 
   за что были списаны или начислены деньги, с подробным описанием каждой из задач.
   * Actor - Any authorized user
   * Command - Show tasks breakdown for user (show user's account)
   * Data - User id (developer id?), tasks id, tasks titles, tasks descriptions, tasks cost
   * Event - Account.Showed

4. Расценки:
   4.1 Цена на задачу определяется единоразово, в момент ее появления в системе 
   (можно с минимальной задержкой)
     * Actor - Task.Created
     * Command - Assign task cost
     * Data - Task id
     * Event - Task.CostAssigned

   4.2 У сотрудника появилась новая задача — `rand(-10..-20)$`
     * Actor - Task.Assigned
     * Command - Apply task's cost to user's account balance. Cost should be between -10 and - 20$
     * Data - Task id, user id, task cost
     * Event - Account.TaskCostAssigned
   
   4.3 Сотрудник выполнил задачу — `rand(20..40)$`
     * Actor - Task.Completed
     * Command - Apply task's completion reward to user's account balance. 
       Reward should be between 20 and 40$
     * Data - Task id, user id, task cost
     * Event - Account.TaskRewardAssigned
   
   4.4 Отрицательный баланс переносится на следующий день
     * Actor - Day.Ended (or manually via User accountant actor)
     * Command - Negative balance move to next day
     * Data - User id, non completed tasks ids, non completed tasks cost
     * Event - Account.MigrateCurrentTasksCost
   
5. Вверху выводить количество заработанных топ менеджером за сегодня денег.
   * Actor - AccountingDashboard.Showed
   * Command - Calculate top manager profit via 
     `(sum(completed task amount) + sum(created task fee)) * -1` formula
   * Data - Tasks ids, tasks cost, tasks reward, tasks status
   * Event - AccountingDashboard.TopManagerProfitShowed
   
6. В конце дня необходимо считать, сколько денег сотрудник получил за рабочий день, 
   слать на почту сумму выплаты.  

   6.1 Считаем, сколько сотрудник получил за день
      * Actor - Day.Ended (or manually via User accountant actor)
      * Command - Calculate developer compensation
      * Data - User id, task ids, tasks status, tasks cost, tasks reward 
      * Event - Account.DeveloperCompensationCalculated  
   
   6.2 Отправляем сотруднику информацию на почту
      * Actor - Account.DeveloperCompensationCalculated
      * Command - Sent notification to developer via email
      * Data - User id, calculated compensation from event
      * Event - Account.DeveloperCompensationNotificationSent
   
7. После выплаты баланса (в конце дня) он должен обнуляться и в аудитлоге должно быть отображено, 
   что была выплачена сумма.
   7.1. Обнуляем баланс
   * Actor - Day.Ended / Account.PaymentsCompleted (or manually via User accountant actor)
   * Command - Nullify positive balance
   * Data - Users id, users' account information
   * Event - Account.BalanceNullified

   7.2. Сохраняем информацию о выплате в аудит логе
   * Actor - Account.BalanceNullified
   * Command - Sent information to audit log
   * Data - Users id, users' account information
   * Event - Account.PaymentAuditInformationLogged
   
8. Дашборд должен выводить информацию по дням, а не за весь период сразу.
   * Actor - Any authorized user
   * Command - Show relevant information per day
   * Data - N/A
   * Event - AccountingDashboard.Showed
   
## Analytics
1. Аналитика - это отдельный дашборд, доступный только админам.
   * Actor - Authorized user (administrator)
   * Command - Show Dashboard
   * Data - N/A
   * Event - AnalyticsDashboard.Showed
   
2. Нужно указывать, сколько заработал топ-менеджмент за сегодня: сколько попугов ушло в минус.
   * Actor - AnalyticsDashboard.Showed
   * Command - Show top manager profit
   * Data - Users ids, tasks ids, tasks status, tasks reward, tasks cost
   * Event - Analytics.TopManagerProfitCalculated
   
3. Нужно показывать самую дорогую задачу за: день, неделю и месяц.
   * Actor - AnalyticsDashboard.Showed
   * Command - Show the most expensive (costly) task
   * Data - Users ids, tasks ids, tasks status, tasks reward
   * Event - Analytics.MostExpensiveTaskCalculated
