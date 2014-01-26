class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.search(params[:search])
      #@tickets = Ticket.all
    @part =""
    if current_staff
      @part = "staff"
    else
      render "welcome"
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.reference = Ticket.generate_reference
    @ticket.status = "Waiting for Staff Response"
    respond_to do |format|
      if @ticket.save
        TicketMailer.ticket_registration(@ticket).deliver
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        @ticket.status = "Waiting for Staff Response"
        @ticket.save
        TicketMailer.ticket_registration(@ticket).deliver
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  # takes ownership on ticket
  def own
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.staff_id = current_staff.id
    @ticket.status = "On hold"
    @ticket.save
    TicketMailer.on_hold(@ticket).deliver
    TicketMailer.change_owner(@ticket, current_staff).deliver
    render 'show'
  end

  def reply
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.status = "Waiting for customer"
    @ticket.save
    @responce = params[:reply]
    TicketMailer.responce(@ticket, @responce).deliver
    redirect_to tickets_path
  end

  def status
    @ticket = Ticket.find(params[:ticket_id])
    @ticket.status = params[:status]
    @ticket.save
      if params[:status].to_s == "Completed"
          TicketMailer.completed(@ticket).deliver
      else
          TicketMailer.canceled(@ticket).deliver
      end
    redirect_to tickets_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :email, :issue, :body, :reference, :status, :staff_id)
    end
end
