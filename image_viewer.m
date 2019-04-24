% Sweet Image Viewer
% Author: William Jackson

function [] = image_viewer()

x_pos_lc = 0.87 ;
x_pos_rc = 0.887;
num_width = 0.02;
num_height = 0.017;

y_pos = 0.34;
y_spacing = 0.02;

fig_han.fh = figure('units','Normalized',...
    'position',[0,0,0.9,0.9],...
    'menubar','none',...
    'name','Image Viewer',...
    'numbertitle','off',...
    'resize','on',... % you can fix it so its scalable
    'WindowKeyPressFcn',@key_press);

fig_han.ha = axes('Units','Normalized','Position',[0.033,0.033,0.8,0.8]);

fig_han.inc_text = uicontrol('Style','text','String','Inc  Pos',...
    'HorizontalAlignment','left',...
    'Units','Normalized', 'Position',[x_pos_lc,y_pos,0.04,num_height]);

fig_han.i_inc_str = uicontrol('Style','edit','String','1',...
    'Units','Normalized',...
    'Position',[x_pos_lc,y_pos-y_spacing,num_width,num_height]);
fig_han.j_inc_str = uicontrol('Style','edit','String','1',...
    'Units','Normalized',...
    'Position',[x_pos_lc,y_pos-2*y_spacing,num_width,num_height]);
fig_han.k_inc_str = uicontrol('Style','edit','String','1',...
    'Units','Normalized',...
    'Position',[x_pos_lc,y_pos-3*y_spacing,num_width,num_height]);

fig_han.i_pos_str = uicontrol('Style','edit','String','0',...
    'Units','Normalized',...
    'Position',[x_pos_rc,y_pos-y_spacing,num_width,num_height]);
fig_han.j_pos_str = uicontrol('Style','edit','String','0',...
    'Units','Normalized',...
    'Position',[x_pos_rc,y_pos-2*y_spacing,num_width,num_height]);
fig_han.k_pos_str = uicontrol('Style','edit','String','0',...
    'Units','Normalized',...
    'Position',[x_pos_rc,y_pos-3*y_spacing,num_width,num_height]);

fig_han.base_test = uicontrol('Style','text','String',...
    'File Name Pattern','Units','Normalized',...
    'Position',[x_pos_lc,y_pos-5*y_spacing,0.1,num_height],...
    'HorizontalAlignment','left');

fig_han.base_name = uicontrol('Style','edit','String',...
    'image_{}_{}_{}.bmp',...
    'Units','Normalized',...
    'Position',[x_pos_lc,y_pos-6*y_spacing,0.1,num_height]);

fig_han.load = uicontrol('Style','pushbutton','String','Load',...
    'Units','Normalized',...
    'Position',[x_pos_lc,y_pos-7*y_spacing,0.04,num_height],...
    'Callback', {@load_reset_Callback});

fig_han.image_path = '';

fig_han.enabled = 0;
fig_han.message_shown = 0;


    function key_press(~, eventdata)
        
        if fig_han.enabled
            
            draw_it = 0;
            ii = str2double(fig_han.i_pos_str.String);
            jj = str2double(fig_han.j_pos_str.String);
            kk = str2double(fig_han.k_pos_str.String);
            
            curr_inc_i = str2double(fig_han.i_inc_str.String);
            curr_inc_j = str2double(fig_han.j_inc_str.String);
            curr_inc_k = str2double(fig_han.k_inc_str.String);
            
            
            switch eventdata.Key
                
                case('leftarrow')
                    ii = ii - curr_inc_i;
                    draw_it = 1;
                case('rightarrow')
                    ii = ii + curr_inc_i;
                    draw_it = 1;
                case('uparrow')
                    jj = jj + curr_inc_j;
                    draw_it = 1;
                case('downarrow')
                    jj = jj - curr_inc_j;
                    draw_it = 1;
                case('pageup')
                    kk = kk + curr_inc_k;
                    draw_it = 1;
                case('pagedown')
                    kk = kk - curr_inc_k;
                    draw_it = 1;
            end
            
            if draw_it
                fig_han.i_pos_str.String = num2str(ii);
                fig_han.j_pos_str.String = num2str(jj);
                fig_han.k_pos_str.String = num2str(kk);
                load_and_display()
            end
            
        else
            if not(fig_han.message_shown)
                disp('Click load to enable scrolling with keys')
                fig_han.message_shown = 1;
            end
        end
    end

    function load_reset_Callback(~, ~)
        load_and_display()
    end


    function get_file_name()
        
        input_string = fig_han.base_name.String;
        splits = strsplit(input_string,'{}');
        len = length(splits);
        if len>1 && len <=4
            im_string = "";
        else
            disp('Invalid image string')
            return
        end
        
        number_strings = {fig_han.i_pos_str.String,...
            fig_han.j_pos_str.String, fig_han.k_pos_str.String};
        
        for ii = 1:len-1
            im_string = im_string + splits{ii};
            im_string = im_string + number_strings{ii};
        end
        
        im_string = im_string + splits{end};
        
        fig_han.image_path = char(im_string);
        
    end


    function load_and_display()
        
        fig_han.enabled = 1;
        
        get_file_name();
        
        try
            image = imread(fig_han.image_path);
            imshow(image);
        catch % should rethrow errors that arent file not found...
            disp('Image not found')
            disp(fig_han.image_path);
            return
        end
        
    end

end