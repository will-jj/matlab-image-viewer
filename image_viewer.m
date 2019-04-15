% Sweet Image Viewer
% Author: William Jackson

function [] = image_viewer()
fig_han.fh = figure('units','pixels',...
    'position',[100,100,1500,1000],...
    'menubar','none',...
    'name','Image Viewer',...
    'numbertitle','off',...
    'resize','off',... % you can fix it so its scalable
    'WindowKeyPressFcn',@key_press);

fig_han.ha = axes('Units','Pixels','Position',[50,50,1200,800]);

fig_han.inc_text = uicontrol('Style','text','String','Inc  Pos',...
    'Position',[1300,500,60,25]);

fig_han.i_inc_str = uicontrol('Style','edit','String','1',...
    'Position',[1300,480,30,25]);
fig_han.j_inc_str = uicontrol('Style','edit','String','1',...
    'Position',[1300,440,30,25]);
fig_han.k_inc_str = uicontrol('Style','edit','String','1',...
    'Position',[1300,400,30,25]);

fig_han.i_pos_str = uicontrol('Style','edit','String','0',...
    'Position',[1330,480,30,25]);
fig_han.j_pos_str = uicontrol('Style','edit','String','0',...
    'Position',[1330,440,30,25]);
fig_han.k_pos_str = uicontrol('Style','edit','String','0',...
    'Position',[1330,400,30,25]);

fig_han.base_test = uicontrol('Style','text','String','Base File Name',...
    'Position',[1300,300,150,25],'HorizontalAlignment','left');

fig_han.base_name = uicontrol('Style','edit','String','image',...
    'Position',[1300,280,100,25]);

fig_han.base_test = uicontrol('Style','text','String','File Extension',...
    'Position',[1300,240,100,25],'HorizontalAlignment','left');

fig_han.file_type = uicontrol('Style','edit','String','.bmp',...
    'Position',[1300,220,80,25]);

fig_han.load = uicontrol('Style','pushbutton','String','Load',...
    'Position',[1300,160,60,25],...
    'Callback', {@load_reset_Callback});

fig_han.image_path = '';


    function key_press(~, eventdata)
        
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
        
    end

    function load_reset_Callback(~, ~)
        load_and_display()
    end


    function get_file_name()
        
        fig_han.image_path = sprintf('%s_%s_%s_%s%s',....
            fig_han.base_name.String, fig_han.i_pos_str.String,...
            fig_han.j_pos_str.String, fig_han.k_pos_str.String,...
            fig_han.file_type.String);
    end


    function load_and_display()
        
        get_file_name();
        
        try
            image = imread(fig_han.image_path);
            imshow(image);
        catch %catch them all yolo
            disp('Image not found')
            disp(fig_han.image_path);
            return
        end
        
    end

end