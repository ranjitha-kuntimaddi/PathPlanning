function  Visualisation(obj)
output_port = 23000;
number_of_retries = 10;

import java.net.ServerSocket
import java.io.*

    retry             = 0;

    server_socket  = [];
    output_socket  = [];

    while true

        retry = retry + 1;

        try
            if ((number_of_retries > 0) && (retry > number_of_retries))
                fprintf(1, 'Too many retries\n');
                break;
            end

            fprintf(1, ['Try %d waiting for client to connect to this ' ...
                        'host on port : %d\n'], retry, output_port);

            % wait for 1 second for client to connect server socket
            server_socket = ServerSocket(output_port);
            server_socket.setSoTimeout(1000);

            output_socket = server_socket.accept;

            fprintf(1, 'Client connected\n');

            output_stream   = output_socket.getOutputStream;
            d_output_stream = DataOutputStream(output_stream);

           % output the data over the DataOutputStream
            %Convert to stream of bytes
            
  for x = 1:obj.number_of_elements-2
      
   temp_frame = obj.get_frame(x);
    temp_frame(1,4) = temp_frame(1,4).*1.5;
    temp_frame(2,4) = temp_frame(2,4).*1.5;
    temp_frame(3,4) = temp_frame(3,4).*1.5;
   
   

    data = sprintf('<MATLAB><T></T><TX>%f</TX><TY>%f</TY><TZ>%f</TZ><NX>%f</NX><OX>%f</OX><AX>%f</AX><NY>%f</NY><OY>%f</OY><AY>%f</AY><NZ>%f</NZ><OZ>%f</OZ><AZ>%f</AZ></MATLAB>\n',...
                        temp_frame(1,4),temp_frame(2,4),temp_frame(3,4),...
                        temp_frame(1,1),temp_frame(2,1),temp_frame(3,1),...
                        temp_frame(1,2),temp_frame(2,2),temp_frame(3,2),...
                        temp_frame(1,3),temp_frame(2,3),temp_frame(3,3));
                    
                    
         
            d_output_stream.writeBytes(char(data));
            d_output_stream.flush;
            pause(0.001)
            
            
  end        
            
            
          
            
            % clean up
            server_socket.close;
            output_socket.close;
            break;
            
            catch
                if ~isempty(server_socket)
                    server_socket.close
                end

                if ~isempty(output_socket)
                    output_socket.close
                end

                % pause before retrying
                pause(1);
        end
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    






end

